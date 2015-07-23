defmodule EctoIt do
  @moduledoc """
  This module implements the Application callbacks for starting and stoping EctoIt
  application, which automaticly make storage_up on start and storage_down on stop.

  ## Configuration

  Your test enviroments can be something like it

      config :ecto_it, Ecto.Adapters.Postgres,
        username: "postgres",
        url: "ecto://postgres:postgres@localhost/"

      config :ecto_it, Ecto.Adapters.MySQL,
        username: "root",
        url: "ecto://root@localhost/"

      config :ecto_it,
        database: "your_database_test"

  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    Application.put_env(:ecto_it, EctoIt.Repo.__repo_module__(), url: get_url())
    Ecto.Storage.up(EctoIt.Repo)
    Supervisor.start_link([worker(EctoIt.Repo, [])], [strategy: :one_for_one, name: EctoIt.Supervisor])
  end

  def stop(_) do
    Ecto.Storage.down(EctoIt.Repo)
  end

  def get_url() do
    Application.get_env(:ecto_it, EctoIt.Repo.__adapter__)[:url] <> database
  end

  def username() do
    Application.get_env(:ecto_it, EctoIt.Repo.__adapter__)[:username]
  end

  def database do
    Application.get_env(:ecto_it, :database, "ecto_test_default")
  end
end
