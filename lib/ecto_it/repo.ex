defmodule EctoIt.Repo do

  def unquote(:"$handle_undefined_function")(program, args) do
    Application.put_env(:ecto_it, EctoIt.get_repo(), adapter: EctoIt.get_adapter(), url: EctoIt.get_url(Mix.env))
    EctoIt.get_adapter().storage_up(username: EctoIt.get_username(Mix.env), database: "ecto_test_default")
    case Mix.env do
      :pg ->
        EctoIt.Repo.Postgres.start_link
      _ ->
        EctoIt.Repo.MySQL.start_link
    end
  end

end

defmodule EctoIt.Repo.Postgres do
  use Ecto.Repo, otp_app: :ecto_it, adapter: Ecto.Adapters.Postgres
end

defmodule EctoIt.Repo.MySQL do
  use Ecto.Repo, otp_app: :ecto_it, adapter: Ecto.Adapters.MySQL
end
