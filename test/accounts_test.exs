defmodule Betfair.AccountsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import Betfair.Accounts
  import Betfair.Session

  setup_all do
    {:ok, session_pid} = Betfair.Session.new
    use_cassette "session#login" do
      wait_for_login session_pid
    end
    {:ok, session_pid: session_pid}
  end

  test "getDeveloperAppKeys", context do
    use_cassette "accounts#getDeveloperAppKeys" do
      assert getDeveloperAppKeys(context[:session_pid], [])
    end
  end

  test "getAccountDetails", context do
    use_cassette "accounts#getAccountDetails" do
      assert getAccountDetails(context[:session_pid], [])
    end
  end

  test "getAccountFunds", context do
    use_cassette "accounts#getAccountFunds" do
      assert getAccountFunds(context[:session_pid], [])
    end
  end

  test "getAccountStatement", context do
    use_cassette "accounts#getAccountStatement" do
      assert getAccountStatement(context[:session_pid])
    end
  end

  test "listCurrencyRates", context do
    use_cassette "accounts#listCurrencyRates" do
      assert %{"currencyCode" => "GBP", "rate" => 1.0} in listCurrencyRates(context[:session_pid], [fromCurrency: "GBP"])
    end
  end

  # test "createDeveloperAppKeys", context do
  #   use_cassette "accounts#createDeveloperAppKeys" do
  #     assert %{} = createDeveloperAppKeys(context[:session_pid])
  #   end
  # end
  #
  # test "transferFunds", context do
  #   use_cassette "accounts#transferFunds" do
  #     assert %{} = transferFunds(context[:session_pid])
  #   end
  # end
  #
  # test "getVendorClientId", context do
  #   use_cassette "accounts#getVendorClientId" do
  #     assert %{} = getVendorClientId(context[:session_pid])
  #   end
  # end
  #
  # test "getApplicationSubscriptionToken", context do
  #   use_cassette "accounts#getApplicationSubscriptionToken" do
  #     assert %{} = getApplicationSubscriptionToken(context[:session_pid])
  #   end
  # end
  #
  # test "activateApplicationSubscription", context do
  #   use_cassette "accounts#activateApplicationSubscription" do
  #     assert %{} = activateApplicationSubscription(context[:session_pid])
  #   end
  # end
  #
  # test "cancelApplicationSubscription", context do
  #   use_cassette "accounts#cancelApplicationSubscription" do
  #     assert %{} = cancelApplicationSubscription(context[:session_pid])
  #   end
  # end
  #
  # test "updateApplicationSubscription", context do
  #   use_cassette "accounts#updateApplicationSubscription" do
  #     assert %{} = updateApplicationSubscription(context[:session_pid])
  #   end
  # end
  #
  # test "listApplicationSubscriptionTokens", context do
  #   use_cassette "accounts#listApplicationSubscriptionTokens" do
  #     assert %{} = listApplicationSubscriptionTokens(context[:session_pid])
  #   end
  # end
  #
  # test "listAccountSubscriptionTokens", context do
  #   use_cassette "accounts#listAccountSubscriptionTokens" do
  #     assert %{} = listAccountSubscriptionTokens(context[:session_pid])
  #   end
  # end
  #
  # test "getApplicationSubscriptionHistory", context do
  #   use_cassette "accounts#getApplicationSubscriptionHistory" do
  #     assert %{} = getApplicationSubscriptionHistory(context[:session_pid])
  #   end
  # end
  #
  # test "can get vendor client id", context do
  #   use_cassette "accounts#vendorid" do
  #     assert 361260 = getVendorClientId(context[:session_pid])
  #   end
  # end

end
