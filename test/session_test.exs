defmodule Betfair.SessionTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import Betfair.Session

  test "login is not performed proactively" do
    use_cassette "session#newsession" do
      {:ok, session_pid} = Betfair.Session.new
      assert get_token(session_pid) == nil
    end
  end

  test "login works" do
    use_cassette "session#login" do
      {:ok, session_pid} = Betfair.Session.new
      wait_for_login session_pid
    end
  end
end
