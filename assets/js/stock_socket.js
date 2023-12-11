// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// Bring in Phoenix channels client library:
import {Socket} from "phoenix"

// And connect to the path in "lib/walden_web/endpoint.ex". We pass the
// token for authentication. Read below how it should be used.
let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/walden_web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/walden_web/templates/layout/app.html.heex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/3" function
// in "lib/walden_web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket, _connect_info) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1_209_600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, connect to the socket:

socket.connect()

// Now that you are connected, you can join channels with a topic.
// Let's assume you have a channel with a topic named `room` and the
// subtopic is its id - in this case 42:
let channel = socket.channel("room:stock", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })


  channel.on('stock_update', msg => {
      let table = document.getElementById("empty-stock-tbody")
      let tableDiv = document.getElementById("new-stock-list")

      let htmlString = 
        `
        <tr>
          <td class="pl-4">
              <input form="my-form${msg.id}" type="number" name="weight" required="true" value=${msg.weight} class="p-2 border rounded" />
          </td>
          <input form="my-form${msg.id}" type="hidden" name="id" value=${msg.id} />
          <td class="py-2 px-4 border-b">
              <select form="my-form${msg.id}" required="true" id="status" name="status" class="border rounded">
                  <option value="L">L</option>
                  <option value="P">P</option>
                  <option value="D">D</option>
              </select>
          </td>
          <td  class="py-2 px-4 border-b"><input type="Submit" form="my-form${msg.id}" class="p-2 bg-blue-500 text-white rounded"/></td>
        </tr>
        `

      let formString = 
        `
          <form action="/edit" method="POST" id="my-form${msg.id}" class="flex flex-col items-center">
          </form>
        `

      table.insertAdjacentHTML('beforeend', htmlString)
      tableDiv.insertAdjacentHTML('beforeend', formString)


      if(tableDiv.classList.contains("hidden")) {
        tableDiv.classList.remove("hidden")
      }

      console.log(table)
      // console.log("updating stock...", msg)
  })

export default socket
