defmodule Betfair.SessionTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import Betfair.Session

  test "login is not performed proactively" do
    use_cassette "session#newsession" do
      {:ok, session_pid} = Betfair.Session.new
      assert get_state(session_pid).session_token == nil
    end
  end

  test "login works" do
    use_cassette "session#login" do
      {:ok, session_pid} = Betfair.Session.new
      :ok = Betfair.Session.login session_pid
      assert get_state(session_pid).session_token != nil
    end
  end
end
