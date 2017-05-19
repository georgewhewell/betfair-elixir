defmodule Betfair.SessionTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import Betfair.Session

  test "login is not performed proactively" do
    use_cassette "session#newsession" do
      {:ok, session_pid} = Betfair.Session.new
      %Betfair.Session{session_token: token} = get_state(session_pid)
      assert token == nil
    end
  end

  test "login manually" do
    use_cassette "session#login" do
      {:ok, session_pid} = Betfair.Session.new
      :ok = Betfair.Session.wait_for_login session_pid
      %Betfair.Session{session_token: token} = get_state(session_pid)
      assert token != nil
    end
  end

  test "lazy login" do
    use_cassette "session#lazylogin" do
      {:ok, session_pid} = Betfair.Session.new
      %Betfair.Session{session_token: token} = get_state(session_pid)
      assert token == nil
      Betfair.Accounts.getAccountDetails session_pid
      %Betfair.Session{session_token: token} = get_state(session_pid)
      assert token != nil
    end
  end
end
