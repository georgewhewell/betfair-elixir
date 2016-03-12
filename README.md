# betfair-elixir [![Build Status](https://travis-ci.org/georgewhewell/betfair-elixir.svg?branch=master)](https://travis-ci.org/georgewhewell/betfair-elixir)
A stateful wrapper for Betfair API using [httpoison](https://github.com/edgurgel/httpoison) 

## Installation

  1. Add betfair to your list of dependencies in mix.exs:

        def deps do
          [{:betfair, "~> 0.0.1"}]
        end

  2. Ensure betfair is started before your application:

        def application do
          [applications: [:betfair]]
        end

  3. Add betfair config (see config/test.exs). Refer to [betfair-py](https://github.com/jmcarp/betfair.py) for instructions to generate SSL certs.

## Usage

  1. Create Betfair Session
  
        $ iex -S mix
        Erlang/OTP 18 [erts-7.2.1] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
        Interactive Elixir (1.2.1) - press Ctrl+C to exit (type h() ENTER for help)
        iex(1)> import Betfair        
        nil
        iex(2)> {:ok, session} = Betfair.Session.new()
        {:ok, #PID<0.215.0>}

  2. Perform RPC:
      
        iex(3)> Betfair.Accounts.getAccountFunds session    
        %{"availableToBetBalance" => 4.71, "discountRate" => 0.0, "exposure" => 0.0,
          "exposureLimit" => -1.0e4, "pointsBalance" => 0, "retainedCommission" => 0.0,
          "wallet" => "UK"}
