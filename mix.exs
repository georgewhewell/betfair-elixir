defmodule Betfair.Mixfile do
  use Mix.Project

  def project do
    [app: :betfair,
     version: "0.0.1",
     elixir: "~> 1.1-dev",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     preferred_cli_env: [
       vcr: :test, "vcr.delete": :test, "vcr.check": :test, "vcr.show": :test
     ],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :httpoison, :exjsx]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
   [ {:httpoison, "~> 0.8" },
     {:exjsx, "~> 3.2" },
     {:earmark, "~> 0.1.17", only: :docs},
     {:ex_doc, "~> 0.8.0", only: :docs},
     {:inch_ex, only: :docs},
     {:excoveralls, "~> 0.4", only: :test},
     {:exvcr, "~> 0.7.1", only: :test},
     {:meck, "~> 0.8", only: :test},
     {:exactor, "~> 2.2.0"}]
  end
end
