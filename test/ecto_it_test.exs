defmodule Test.Model do
  use Ecto.Model

  schema "test" do
    field :test, :string
    timestamps
  end
end

defmodule EctoItTest do
  use ExUnit.Case
  alias EctoIt.Repo
  alias Test.Model
  import Ecto.Query
  doctest EctoIt

  setup do
    {:ok, _} = Application.ensure_all_started(:ecto_it)
    on_exit fn -> :application.stop(:ecto_it) end
  end

  test "the truth" do
    dir = Path.join([File.cwd!, "test", "migration"])
    assert [1] = Ecto.Migrator.run Repo, dir, :up, [all: true, log: false]
    assert %{} = Repo.insert!(%Model{test: "foo"})
    assert [%{test: "foo"}] = Repo.all from m in Model, where: m.test == "foo"
    assert [1] = Ecto.Migrator.run Repo, dir, :down, [all: true, log: false]
    assert 1 + 1 == 2
  end
end
