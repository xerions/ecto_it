defmodule EctoIt.Repo do
  @moduledoc """
  Defines a repository.

  A repository maps to an underlying data store, controlled by the
  adapter. Please refer to `Ecto.Repo` for more information about.

  Depends on MIX_ENV (pg or mysql) it will calls to EctoIt.Repo apply
  on EctoIt.Repo.Postgres or EctoIt.Repo.MySQL, which use adaptor
  Postgres and Mysql respectively.
  """
  def unquote(:"$handle_undefined_function")(function, args) do
    __repo_module__ |> apply(function, args)
  end

  def __repo_module__ do
    case Mix.env do
      :pg ->
        EctoIt.Repo.Postgres
      _ ->
        EctoIt.Repo.MySQL
    end
  end
end

defmodule EctoIt.Repo.Postgres do
  use Ecto.Repo, otp_app: :ecto_it, adapter: Ecto.Adapters.Postgres
end

defmodule EctoIt.Repo.MySQL do
  use Ecto.Repo, otp_app: :ecto_it, adapter: Ecto.Adapters.MySQL
end
