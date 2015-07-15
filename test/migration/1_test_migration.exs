defmodule Test.Migrations.CreateTest do
  use Ecto.Migration

  def change do
    create table(:test) do
      add :test, :string
      timestamps
    end
  end
end
