defmodule Walden.Repo.Migrations.CreateStocks do
  use Ecto.Migration

  def change do
    create table(:stocks) do
      add :weight, :decimal
      add :status, :string

      timestamps()
    end
  end
end
