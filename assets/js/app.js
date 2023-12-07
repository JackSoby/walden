// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket



document.addEventListener("DOMContentLoaded", function() {
    const openModalButton = document.getElementById('openModalButton');
    const closeModalButton = document.getElementById('closeModalButton');
    const modal = document.getElementById('myModal');

    openModalButton.addEventListener('click', function() {
        modal.classList.remove('hidden');
    });

    closeModalButton.addEventListener('click', function() {
        modal.classList.add('hidden');
    });

    modal.addEventListener('click', function(event) {
        if (event.target === modal) {
            modal.classList.add('hidden');
        }
    });
});


document.addEventListener("DOMContentLoaded", function() {
    const tabs = document.querySelectorAll('ul.flex a');
    tabs.forEach(tab => {
        tab.addEventListener('click', function (e) {
            e.preventDefault();
            const previousTab = document.getElementsByClassName('border-blue-500')[0];
            previousTab.classList.remove('border-blue-500');
            
            tab.classList.add('border-blue-500');
            const targetTabId = this.getAttribute('href').substring(1);
            const tabsContent = document.querySelectorAll('.container > div');
            tabsContent.forEach(tabContent => {
                if (tabContent.id === targetTabId) {
                    tabContent.classList.remove('hidden');
                } else {
                    tabContent.classList.add('hidden');
                }
            });
        });
    });
});