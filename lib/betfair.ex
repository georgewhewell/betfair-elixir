defmodule Betfair do
  use HTTPoison.Base

  @accept [{"Accept", "application/json"}]
  @content_type [{"Content-Type", "application/json"}]

  @type response :: {integer, any} | :jsx.json_term

  @spec process_response(HTTPoison.Response.t) :: response
  def process_response(%HTTPoison.Response{status_code: 200, body: ""}), do: nil
  def process_response(%HTTPoison.Response{status_code: 200, body: body }) do
    case JSX.decode!(body) do
      %{"jsonrpc" => "2.0", "result" => result} ->
        result
      result ->
        result
    end
  end
  def process_response(%HTTPoison.Response{status_code: status_code, body: ""}), do: { status_code, nil }
  def process_response(%HTTPoison.Response{status_code: status_code, body: body}), do: { status_code, JSX.decode!(body) }

  def post(client, service, path, body) do
    options = [ssl: [certfile: client.cert_file, keyfile: client.key_file]]
    request!(:post, url(service, path), body, application_header(client.app_key, @accept), options) |> process_response
  end

  def post_login(identity) do
    options = [ssl: [certfile: identity.cert_file, keyfile: identity.key_file]]
    form = {:form, [username: identity.username, password: identity.password]}
    headers = application_header(identity.app_key, @accept)
    data = request!(:post, url(:identity, "certlogin"), form, headers, options)
    case process_response(data) do
      %{"loginStatus" => "SUCCESS", "sessionToken" => session_token} -> {:ok, session_token}
      badresp -> {:error, "Bad response: #{inspect badresp}"}
    end
  end

  def call_rpc(session_pid, service, method, params) do
    session = Betfair.Session.get_state session_pid
    url = url(service)
    body = make_rpc_body(method, params)
    headers = application_header(session.app_key, session_header(session.session_token, @accept ++ @content_type))
    options = [ssl: [certfile: session.cert_file, keyfile: session.key_file]]
    request!(:post, url, body, headers, options) |> process_response
  end

  defp url(:identity, path), do: "https://identitysso.betfair.com/api/" <> path
  @spec url(service :: atom) :: binary
  defp url(:accounts), do: "https://api.betfair.com/exchange/account/json-rpc/v1/"
  defp url(:betting), do: "https://api.betfair.com/exchange/betting/json-rpc/v1/"

  def make_rpc_body(method, params) do
    JSX.encode!(%{jsonrpc: "2.0", method: method, params: params})
  end

  @spec application_header(binary, list) :: list
  def application_header(app_key, headers), do: [{"X-Application", app_key} | headers]

  @spec session_header(binary, list) :: list
  def session_header(token, headers), do: [{"X-Authentication", token} | headers]

end
