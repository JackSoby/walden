defmodule Walden.InventoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Walden.Inventory` context.
  """

  @doc """
  Generate a stock.
  """
  def stock_fixture(attrs \\ %{}) do
    {:ok, stock} =
      attrs
      |> Enum.into(%{
        status: "some status",
        weight: 42
      })
      |> Walden.Inventory.create_stock()

    stock
  end
end
