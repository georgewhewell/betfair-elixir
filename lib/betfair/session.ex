defmodule Betfair.Session do
  defstruct [:app_key, :certfile, :keyfile, :username, :password, :session_token]

  def new(_)
  def new(auth = %__MODULE__{}), do: Agent.start_link(fn -> auth end)
  def new(auth = %{}), do: new Map.merge(%__MODULE__{}, auth)
  def new(auth), do: new Kernel.struct(%__MODULE__{}, auth)
  def new(), do: new Application.get_all_env(:betfair)

  def get_state(agent), do: Agent.get(agent, fn state -> state end)
  def wait_for_login(agent), do: Agent.update(agent, fn state -> login(state) end)

  defp login(state = %__MODULE__{session_token: token}) when token != nil, do: state
  defp login(state = %__MODULE__{}) do
    case Betfair.post_login(state) do
      {:ok, session_token} -> %__MODULE__{ state | session_token: session_token }
    end
  end
end
