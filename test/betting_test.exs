defmodule Betfair.BettingTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import Betfair.Betting
  import Betfair.Session

  setup_all do
    {:ok, session_pid} = Betfair.Session.new
    use_cassette "session#login" do
      wait_for_login session_pid
    end
    {:ok, session_pid: session_pid}
  end

  test "listEventTypes", context do
    use_cassette "betting#listEventTypes" do
      assert listEventTypes(context[:session_pid], [maxResults: 1, filter: [inPlayOnly: :true]])
    end
  end

  test "listCompetitions", context do
    use_cassette "betting#listCompetitions" do
      assert listCompetitions(context[:session_pid], [maxResults: 1, filter: [inPlayOnly: :true]])
    end
  end

  test "listEvents", context do
    use_cassette "betting#listEvents" do
      assert listEvents(context[:session_pid], [maxResults: 1, filter: [inPlayOnly: :true]])
    end
  end

  test "listMarketTypes", context do
    use_cassette "betting#listMarketTypes" do
      assert listMarketTypes(context[:session_pid], [maxResults: 1, filter: [inPlayOnly: :true]])
    end
  end

  test "listCountries", context do
    use_cassette "betting#listCountries" do
      assert listCountries(context[:session_pid], [maxResults: 1, filter: [inPlayOnly: :true]])
    end
  end

  test "listVenues", context do
    use_cassette "betting#listVenues" do
      assert listVenues(context[:session_pid], [maxResults: 1, filter: [inPlayOnly: :true]])
    end
  end

  test "listMarketCatalogue", context do
    use_cassette "betting#listMarketCatalogue" do
      assert listMarketCatalogue(context[:session_pid], [maxResults: 1, filter: [inPlayOnly: :true]])
    end
  end

  test "listMarketBook", context do
    use_cassette "betting#listMarketBook" do
      assert listMarketBook(context[:session_pid], [marketIds: ["1.118474828"]])
    end
  end

  test "listMarketProfitAndLoss", context do
    use_cassette "betting#listMarketProfitAndLoss" do
      assert listMarketProfitAndLoss(context[:session_pid], [marketIds: ["1.118474828"]])
    end
  end

  test "listCurrentOrders", context do
    use_cassette "betting#listCurrentOrders" do
      assert listCurrentOrders(context[:session_pid])
    end
  end

  test "listClearedOrders", context do
    use_cassette "betting#listClearedOrders" do
      assert %{} = listClearedOrders(context[:session_pid], [betStatus: "SETTLED"])
    end
  end

  # test "listTimeRanges", context do
  #   use_cassette "betting#listTimeRanges" do
  #     assert %{} = listTimeRanges(context[:session_pid])
  #   end
  # end
  #
  # test "placeOrders", context do
  #   use_cassette "betting#placeOrders" do
  #     assert %{} = placeOrders(context[:session_pid])
  #   end
  # end
  #
  # test "cancelOrders", context do
  #   use_cassette "betting#cancelOrders" do
  #     assert %{} = cancelOrders(context[:session_pid])
  #   end
  # end
  #
  # test "replaceOrders", context do
  #   use_cassette "betting#replaceOrders" do
  #     assert %{} = replaceOrders(context[:session_pid])
  #   end
  # end
  #
  # test "updateOrders", context do
  #   use_cassette "betting#updateOrders" do
  #     assert %{} = updateOrders(context[:session_pid])
  #   end
  # end
end
