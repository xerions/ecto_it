defmodule EctoIt do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    Supervisor.start_link([worker(EctoIt.Repo, [])], [strategy: :one_for_one, name: EctoIt.Supervisor])
  end

  def stop(_) do
    get_adapter().storage_down(database: "ecto_test_default", username: get_username(Mix.env))
  end

  def get_repo() do
    case Mix.env do
      :pg -> EctoIt.Repo.Postgres
      _ -> EctoIt.Repo.MySQL
    end
  end

  def get_adapter() do
    case Mix.env do
      :pg -> Ecto.Adapters.Postgres
      _   -> Ecto.Adapters.MySQL
    end
  end

  def get_url(:pg) do
    "ecto://postgres:postgres@localhost/ecto_test_default"
  end

  def get_url(_) do
    "ecto://root@localhost/ecto_test_default"
  end

  def get_username(:pg) do
    "postgres"
  end

  def get_username(_) do
  end

  def stop() do
  end

end
