defmodule Betfair.Session do
  use ExActor.GenServer

  import IO
  def login(identity) do
    login_resp = Betfair.post_login identity
    %{"loginStatus" => "SUCCESS", "sessionToken" => session_token} = login_resp
    %{app_key: identity.app_key, certfile: identity.certfile, keyfile: identity.keyfile, session_token: session_token}
  end

  def new(), do: new(Enum.into(Application.get_all_env(:betfair), %{}))
  def new(auth), do: GenServer.start_link(Betfair.Session, auth)

  definit auth, do: initial_state(auth)

  defcall wait_for_login, state: state, do: set_and_reply(login(state), :ok)

  defcall get_state, state: state = %{session_token: _}, do: reply(state)
  defcall get_state, state: state do
    new_state = login(state)
    set_and_reply(new_state, new_state)
  end

  defcall get_token, state: state = %{session_token: session_token}, do: reply(session_token)
  defcall get_token, state: state, do: reply(nil)
end
