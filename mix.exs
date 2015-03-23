defmodule EctoIt.Mixfile do
  use Mix.Project

  def project do
    [app: :ecto_it,
     version: "0.0.1",
     elixir: "~> 1.1-dev",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger],
     mod: {EctoIt, []},
     env: [
       {:database, "ecto_test_default"},
       {EctoIt.Repo, [adapter: Ecto.Adapters.Postgres]},
       {Ecto.Adapters.Postgres,
         [username: "postgres",
          url: "ecto://postgres:postgres@localhost/"]},
       {Ecto.Adapters.MySQL,
         [username: "root",
          url: "ecto://root@localhost/"]}
     ]
   ]
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
    [{:postgrex, ">= 0.0.0"},
     {:mariaex, ">= 0.0.0"},
     {:ecto, "~> 0.10.0"}]
  end
end
