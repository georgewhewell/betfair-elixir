defmodule Betfair.Session do

  defstruct [:app_key, :cert_file, :key_file, :username, :password, :session_token]

  def new(), do: new Kernel.struct(%__MODULE__{}, Application.get_all_env(:betfair))
  def new(auth), do: Agent.start_link(fn -> auth end)

  defp _login(state = %__MODULE__{}) do
    case Betfair.post_login(state) do
      {:ok, session_token} -> %__MODULE__{ state | session_token: session_token }
    end
  end

  def login(agent), do: Agent.update(agent, fn state -> _login(state) end)

  defp _token(%__MODULE__{session_token: session_token}) when session_token != nil, do: session_token
  defp _token(state), do: _token(_login(state))

  def get_state(agent), do: Agent.get(agent, fn state -> state end)
  def get_token(agent), do: Agent.get(agent, fn state -> _token(state) end)
end
