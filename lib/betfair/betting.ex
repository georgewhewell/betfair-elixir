defmodule Betfair.Betting do
  import Betfair

  @method_path "SportsAPING/v1.0/"

  def listEventTypes(session_pid, params \\ []) do
    call_rpc session_pid, :betting, @method_path <> "listEventTypes", params
  end

  def listCompetitions(session_pid, params \\ []) do
    call_rpc session_pid, :betting, @method_path <> "listCompetitions", params
  end

  def listTimeRanges(session_pid, params \\ []) do
    call_rpc session_pid, :betting, @method_path <> "listTimeRanges", params
  end

  def listEvents(session_pid, params \\ []) do
    call_rpc session_pid, :betting, @method_path <> "listEvents", params
  end

  def listMarketTypes(session_pid, params \\ []) do
    call_rpc session_pid, :betting, @method_path <> "listMarketTypes", params
  end

  def listCountries(session_pid, params \\ []) do
    call_rpc session_pid, :betting, @method_path <> "listCountries", params
  end

  def listVenues(session_pid, params \\ []) do
    call_rpc session_pid, :betting, @method_path <> "listVenues", params
  end

  def listMarketCatalogue(session_pid, params \\ []) do
     call_rpc session_pid, :betting, @method_path <> "listMarketCatalogue", params
  end

  def listMarketBook(session_pid, params \\ []) do
    call_rpc session_pid, :betting, @method_path <> "listMarketBook", params
  end

  def listMarketProfitAndLoss(session_pid, params \\ []) do
    call_rpc session_pid, :betting, @method_path <> "listMarketProfitAndLoss", params
  end

  def listCurrentOrders(session_pid, params \\ []) do
    call_rpc session_pid, :betting, @method_path <> "listCurrentOrders", params
  end

  def listClearedOrders(session_pid, params \\ []) do
    call_rpc session_pid, :betting, @method_path <> "listClearedOrders", params
  end

  def placeOrders(session_pid, params \\ []) do
    call_rpc session_pid, :betting, @method_path <> "placeOrders", params
  end

  def cancelOrders(session_pid, params \\ []) do
    call_rpc session_pid, :betting, @method_path <> "cancelOrders", params
  end

  def replaceOrders(session_pid, params \\ []) do
    call_rpc session_pid, :betting, @method_path <> "replaceOrders", params
  end

  def updateOrders(session_pid, params \\ []) do
    call_rpc session_pid, :betting, @method_path <> "updateOrders", params
  end
end
