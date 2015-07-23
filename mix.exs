defmodule EctoIt.Mixfile do
  use Mix.Project
  @version "0.2.0"
  @github "https://github.com/xerions/ecto_it"

  def project do
    [app: :ecto_it,
     version: @version,
     # Hex
     description: description,
     package: package,

     # Docs
     name: "Ecto IT",
     docs: [source_ref: "v#{@version}",
            source_url: @github],
     deps: deps]
  end

  defp description do
    """
    Ecto IT is library for writing integration tests(with database backend) for ecto-based applications.
    """
  end

  defp package do
    [contributors: ["Dmitry Russ(Aleksandrov)"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => @github}]
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
     {:ex_doc, "~> 0.7", only: :docs},
     {:earmark, "~> 0.1", only: :docs},
     {:ecto, ">= 0.14.0"}]
  end
end
