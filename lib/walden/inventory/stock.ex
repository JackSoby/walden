defmodule Walden.Inventory.Stock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stocks" do
    field :status, :string
    field :weight, :decimal

    timestamps()
  end

  @doc false
  def changeset(stock, attrs) do
    stock
    |> cast(attrs, [:weight, :status])
    |> validate_required([:weight])
  end
end
