defmodule Betfair.Accounts do
  import Betfair

  @method_path "AccountAPING/v1/"

  def createDeveloperAppKeys(session_pid, params \\ []) do
    call_rpc session_pid, :accounts, @method_path <> "createDeveloperAppKeys", params
  end

  def getDeveloperAppKeys(session_pid, params \\ []) do
    call_rpc session_pid, :accounts, @method_path <> "getDeveloperAppKeys", params
  end

  def getAccountFunds(session_pid, params \\ []) do
    call_rpc session_pid, :accounts, @method_path <> "getAccountFunds", params
  end

  def transferFunds(session_pid, params \\ []) do
    call_rpc session_pid, :accounts, @method_path <> "transferFunds", params
  end

  def getAccountDetails(session_pid, params \\ []) do
    call_rpc session_pid, :accounts, @method_path <> "getAccountDetails", params
  end

  def getVendorClientId(session_pid, params \\ []) do
    call_rpc session_pid, :accounts, @method_path <> "getVendorClientId", params
  end

  def getApplicationSubscriptionToken(session_pid, params \\ []) do
    call_rpc session_pid, :accounts, @method_path <> "getApplicationSubscriptionToken", params
  end

  def activateApplicationSubscription(session_pid, params \\ []) do
    call_rpc session_pid, :accounts, @method_path <> "activateApplicationSubscription", params
  end

  def cancelApplicationSubscription(session_pid, params \\ []) do
    call_rpc session_pid, :accounts, @method_path <> "cancelApplicationSubscription", params
  end

  def updateApplicationSubscription(session_pid, params \\ []) do
    call_rpc session_pid, :accounts, @method_path <> "updateApplicationSubscription", params
  end

  def listApplicationSubscriptionTokens(session_pid, params \\ []) do
    call_rpc session_pid, :accounts, @method_path <> "listApplicationSubscriptionTokens", params
  end

  def listAccountSubscriptionTokens(session_pid, params \\ []) do
    call_rpc session_pid, :accounts, @method_path <> "listAccountSubscriptionTokens", params
  end

  def getApplicationSubscriptionHistory(session_pid, params \\ []) do
    call_rpc session_pid, :accounts, @method_path <> "getApplicationSubscriptionHistory", params
  end

  def getAccountStatement(session_pid, params \\ []) do
    call_rpc session_pid, :accounts, @method_path <> "getAccountStatement", params
  end

  def listCurrencyRates(session_pid, params \\ []) do
    call_rpc session_pid, :accounts, @method_path <> "listCurrencyRates", params
  end
end
