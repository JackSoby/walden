# Walden

This app is built on top of Pheonix/Elixir with a Postgres DB

To Install Pheonix/Elixir follow this guide:

https://hexdocs.pm/phoenix/installation.html

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## LPD, How It Works

I have created a demo app for allocating items into LPD categories

As you can see below, I have put sorted the items into three tabbed tables, that can be toggled. one for Loss, one for profit one for donation. Each Item can be edited or deleted.

<img src="Screenshot 2023-12-11 at 11.44.04 AM.png" title="hover text">

Items Can be added manually by clicking the Add button in the top left which will pop up a modal for creating a new LPD item in case of a broken barcode. 

<img src="Screenshot 2023-12-11 at 11.55.03 AM.png" title="hover text">

When an item gets scanned in, an HTTP request is sent to the GUI to create a new item. Once the item is created, the system uses a socket to broadcast a message to the front end of the system, displaying it to be placed into the correct bucket. 

If the weight comes through the barcode scanner, it will be entered into the DB automatically, if the weight does not come through the barcode, it will need to be manully input by the operator.

If you have the app running you can simulate scanning in an item by running the following curl request 
```
curl --location --request POST 'http://localhost:4000/scan?weight=1.4'
```

<img src="Screenshot 2023-12-11 at 11.57.38 AM.png" title="hover text">

Here is a chart giving an overview of how the entire system works

<img src="Screenshot 2023-12-11 at 12.01.54 PM.png" title="hover text">

