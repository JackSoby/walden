defmodule WaldenWeb.InventoryController do
  use WaldenWeb, :controller
  alias Walden.Inventory

  def index(conn, _params) do
    stocks = Inventory.list_stocks()

    {loss, process, donation} =
      stocks
      |> Enum.reduce({[], [], []}, fn %{status: status} = stock, {loss, process, donation} ->
        case status do
          "L" ->
            {loss ++ [stock], process, donation}

          "P" ->
              {loss, process ++ [stock], donation}

          "D" ->
            {loss, process, donation ++ [stock]}
        end


      end)

    render(conn, :index, stockLength: length(stocks), loss: loss, process: process, donation: donation, layout: false)
  end

  def create(conn, stock) do
   case Inventory.create_stock(stock) do
    {:ok, _} ->
      new_conn = put_flash(conn, :info, "Stock Item Created!")

      redirect(new_conn, to: "/")

    {:error, _err} ->
      new_conn = put_flash(conn, :error, "Stock not created, please try again")

      redirect(new_conn, to: "/")
   end
  end


  def scan_stock(conn, %{"weight" => weight}) do

  end
end
