defmodule Betfair do
  use Application
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
    options = [ssl: [certfile: client.certfile, keyfile: client.keyfile]]
    request!(:post, url(service, path), body, application_header(client.app_key, @accept), options) |> process_response
  end

  def post_login(identity) do
    options = [ssl: [certfile: identity.certfile, keyfile: identity.keyfile]]
    headers = application_header(identity.app_key, @accept)
    body = {:form, [username: identity.username, password: identity.password]}
    request!(:post, url(:identity, "certlogin"), body, headers, options) |> process_response
  end

  def call_rpc(session_pid, service, method, params) do
    session = Betfair.Session.get_state session_pid
    url = url(service)
    body = make_rpc_body(method, params)
    headers = application_header(session.app_key, session_header(session.session_token, @accept ++ @content_type))
    options = [ssl: [certfile: session.certfile, keyfile: session.keyfile]]
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
  def application_header(app_key, headers) do
    headers ++ [{"X-Application", app_key}]
  end

  @spec session_header(binary, list) :: list
  def session_header(token, headers) do
    headers ++ [{"X-Authentication", token}]
  end

end
