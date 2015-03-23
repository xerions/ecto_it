defmodule EctoIt do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    database = Application.get_env(:ecto_it, :database)
    adapter = get_adapter()
    adapter_config = Application.get_env(:ecto_it, adapter)
    Application.put_env(:ecto_it, EctoIt.Repo, adapter: adapter, url: (adapter_config[:url] <> database))
    case adapter.storage_up(username: adapter_config[:username], database: database) do
      {:error, :already_up} -> true
      :ok -> true
    end
    Supervisor.start_link([ worker(EctoIt.Repo, []) ], [strategy: :one_for_one, name: EctoIt.Supervisor])
  end

  def stop(_) do
    adapter = get_adapter()
    database = Application.get_env(:ecto_it, :database)
    adapter_config = Application.get_env(:ecto_it, adapter)
    EctoIt.Repo.adapter.storage_down(database: database, username: adapter_config[:username])
  end

  defp get_adapter() do
    case Mix.env do
      :pg -> Ecto.Adapters.Postgres
      _   -> Ecto.Adapters.MySQL
    end
  end
end
