# Walden

This app is built on top of Phoenix/Elixir with a Postgres DB.

To Install Pheonix/Elixir follow this guide:

https://hexdocs.pm/phoenix/installation.html

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## LPD, How It Works

### List Items

I have created a demo app for allocating items into LPD categories.

As you can see below, I have put sorted the items into three tabbed tables. One for Loss, one for process, one for donation. Each Item can be edited or deleted.

<img src="assets/Screenshot 2023-12-11 at 11.44.04 AM.png" title="hover text">

You can toggle between the different statuses by selecting different tabs at the top of the screen

<img src="assets/Screenshot 2023-12-11 at 12.13.15 PM.png" title="hover text">

### Manually Add Item

If an Stock Item has a broken/unscannabled barecode, it may be added manually by clicking the `Add` button in the top left which will pop up a modal for creating a new stock item. 

<img src="assets/Screenshot 2023-12-11 at 11.55.03 AM.png" title="hover text">

### Delete Stock Item

To delete a stock item, simply click the delete button in the actions column, a modal will apear asking for confirmation that you would like to delete. 

<img src="assets/Screenshot 2023-12-11 at 12.18.46 PM.png" title="hover text">

### Edit Stock Item

To edit a stock item, simply click the edit button in the actions column, a modal with a form will apear where you can update your given values and submit. 

<img src="assets/Screenshot 2023-12-11 at 12.17.28 PM.png" title="hover text">


### Barcode Scanner

When an item gets scanned in, an HTTP request is sent to the GUI to create a new item. Once the item is created, the backend of the system uses a socket to broadcast a message to the front end of the system, so it may be placed into the correct bucket. 

If the weight comes through the barcode scanner, it will be entered into the DB automatically, if the weight does not come through the barcode, it will need to be manually input by the operator.

If you have the app running you can simulate scanning in an item by running the following curl request.


```
curl --location --request POST 'http://localhost:4000/scan?weight=1.4'
```

<img src="assets/Screenshot 2023-12-11 at 11.57.38 AM.png" title="hover text">

### Messaging
When a create, update, or delete action happens, the system will always a return a sucess or failure message.

<img src="assets/Screenshot 2023-12-11 at 12.27.16 PM.png" title="hover text">
<img src="assets/Screenshot 2023-12-11 at 12.22.39 PM.png" title="hover text">

### Feature Files 

#### View Files

```
lib/walden_web/controllers/inventory_html/index.html.heex
assets/js/app.js
assets/js/stock_socket.js
```

#### Controller Files

```
lib/walden_web/router.ex
lib/walden_web/controllers/inventory_controller.ex
lib/walden/inventory.ex
```
#### Model Files

```
lib/walden/inventory/stock.ex
priv/repo/migrations/20231206151329_create_stocks.exs
```

### Overview
Here is a high level view of the system.

<img src="assets/Screenshot 2023-12-11 at 12.01.54 PM.png" title="hover text">

