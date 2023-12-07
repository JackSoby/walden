defmodule Walden.InventoryTest do
  use Walden.DataCase

  alias Walden.Inventory

  describe "stocks" do
    alias Walden.Inventory.Stock

    import Walden.InventoryFixtures

    @invalid_attrs %{status: nil, weight: nil}

    test "list_stocks/0 returns all stocks" do
      stock = stock_fixture()
      assert Inventory.list_stocks() == [stock]
    end

    test "get_stock!/1 returns the stock with given id" do
      stock = stock_fixture()
      assert Inventory.get_stock!(stock.id) == stock
    end

    test "create_stock/1 with valid data creates a stock" do
      valid_attrs = %{status: "some status", weight: 42}

      assert {:ok, %Stock{} = stock} = Inventory.create_stock(valid_attrs)
      assert stock.status == "some status"
      assert stock.weight == 42
    end

    test "create_stock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_stock(@invalid_attrs)
    end

    test "update_stock/2 with valid data updates the stock" do
      stock = stock_fixture()
      update_attrs = %{status: "some updated status", weight: 43}

      assert {:ok, %Stock{} = stock} = Inventory.update_stock(stock, update_attrs)
      assert stock.status == "some updated status"
      assert stock.weight == 43
    end

    test "update_stock/2 with invalid data returns error changeset" do
      stock = stock_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_stock(stock, @invalid_attrs)
      assert stock == Inventory.get_stock!(stock.id)
    end

    test "delete_stock/1 deletes the stock" do
      stock = stock_fixture()
      assert {:ok, %Stock{}} = Inventory.delete_stock(stock)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_stock!(stock.id) end
    end

    test "change_stock/1 returns a stock changeset" do
      stock = stock_fixture()
      assert %Ecto.Changeset{} = Inventory.change_stock(stock)
    end
  end
end
