defmodule WaldenWeb.InventoryController do
  use WaldenWeb, :controller
  alias Walden.Inventory

  def index(conn, _params) do
    stocks = Inventory.list_stocks()

    {loss, process, donation, empty} =
      stocks
      |> Enum.reduce({[], [], [], []}, fn %{status: status, weight: weight} = stock, {loss, process, donation, empty} ->
        if weight == nil do
          {loss, process, donation, empty ++ [stock]}
        else
          case status do
            nil ->
              {loss, process, donation, empty ++ [stock]}
            "L" ->
              {loss ++ [stock], process, donation, empty}

            "P" ->
                {loss, process ++ [stock], donation, empty}

            "D" ->
              {loss, process, donation ++ [stock], empty}
          end
        end
      end)

      emptyTableClass =
        if length(empty) <= 0 do
          "container mx-auto mt-4 pb-8 hidden"
        else
          "container mx-auto mt-4 pb-8"
        end

    render(conn, :index, stockLength: length(stocks), emptyTableClass: emptyTableClass, empty: empty, loss: loss, process: process, donation: donation, layout: false)
  end

  def create(conn, stock) do
   case Inventory.create_stock(stock) do
    {:ok, _} ->
      new_conn = put_flash(conn, :info, "Stock Item Created!")

      redirect(new_conn, to: "/")

    {:error, _err} ->
      new_conn = put_flash(conn, :error, "Stock Not Created, Please Try Again")

      redirect(new_conn, to: "/")
   end
  end

  def delete(conn, %{"id" => id} = stock) do
    result =
      id
      |> Inventory.get_stock!
      |> Inventory.delete_stock()

    case result do
      {:ok, _} ->
        new_conn = put_flash(conn, :info, "Stock Item Deleted!")

        redirect(new_conn, to: "/")

      {:error, _err} ->
        new_conn = put_flash(conn, :error, "Error Updating Stock, Please Try Again")

        redirect(new_conn, to: "/")
    end
  end

  def edit(conn, %{"id" => id} = stock) do
    result =
      id
      |> Inventory.get_stock!
      |> Inventory.update_stock(stock)

    case result do
     {:ok, _} ->
       new_conn = put_flash(conn, :info, "Stock Item Updated!")

       redirect(new_conn, to: "/")

     {:error, _err} ->
       new_conn = put_flash(conn, :error, "Error Updating Stock, Please Try Again")

       redirect(new_conn, to: "/")
    end
   end


  def scan(conn, stock) do
    case Inventory.create_stock(stock) do
      {:ok, %{weight: weight, id: id}} ->
        WaldenWeb.Endpoint.broadcast("room:stock", "stock_update", %{weight: weight, id: id})
        send_resp(conn, 200, "Scanned")

      {:error, _err} ->
        WaldenWeb.Endpoint.broadcast("room:stock", "stock_update", "Error Scanning Stock")
        send_resp(conn, 500, "Scanned")
    end
  end
end
