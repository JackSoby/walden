defmodule Walden.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false
  alias Walden.Repo

  alias Walden.Inventory.Stock

  @doc """
  Returns the list of stocks.

  ## Examples

      iex> list_stocks()
      [%Stock{}, ...]

  """
  def list_stocks do
    Stock
    # |> group_by([s], [s.status, s.id])
    |> Repo.all()
  end

  @doc """
  Gets a single stock.

  Raises `Ecto.NoResultsError` if the Stock does not exist.

  ## Examples

      iex> get_stock!(123)
      %Stock{}

      iex> get_stock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stock!(id), do: Repo.get!(Stock, id)

  @doc """
  Creates a stock.

  ## Examples

      iex> create_stock(%{field: value})
      {:ok, %Stock{}}

      iex> create_stock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  # statuses = ["L", "P", "D"]
  # weights = [4.32, 1.12, 5.43, 7.94, 3.56, 2.35, 5.24, 2.69, 4.79, 3.39, 4.32, 6.76, 3.23, 1.21, 1.43, 1.15, 1.1]
  # alias Walden.Inventory
  # number = 1..50
  # numbers |> Enum.to_list() |> Enum.map(fn n -> Inventory.create_stock(%{weight: Enum.random(weights), status: Enum.random(statuses)}) end)

  def create_stock(attrs \\ %{}) do
    %Stock{}
    |> Stock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a stock.

  ## Examples

      iex> update_stock(stock, %{field: new_value})
      {:ok, %Stock{}}

      iex> update_stock(stock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stock(%Stock{} = stock, attrs) do
    stock
    |> Stock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a stock.

  ## Examples

      iex> delete_stock(stock)
      {:ok, %Stock{}}

      iex> delete_stock(stock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stock(%Stock{} = stock) do
    Repo.delete(stock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stock changes.

  ## Examples

      iex> change_stock(stock)
      %Ecto.Changeset{data: %Stock{}}

  """
  def change_stock(%Stock{} = stock, attrs \\ %{}) do
    Stock.changeset(stock, attrs)
  end
end
