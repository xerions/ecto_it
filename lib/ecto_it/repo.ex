defmodule EctoIt.Repo do

  def unquote(:"$handle_undefined_function")(program, args) do
    module = case Mix.env do
               :pg ->
                 EctoIt.Repo.Postgres
               _ ->
                 EctoIt.Repo.MySQL
             end
    apply(module, program, args)
  end
end

defmodule EctoIt.Repo.Postgres do
  use Ecto.Repo, otp_app: :ecto_it, adapter: Ecto.Adapters.Postgres
end

defmodule EctoIt.Repo.MySQL do
  use Ecto.Repo, otp_app: :ecto_it, adapter: Ecto.Adapters.MySQL
end
