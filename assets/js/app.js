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
import Chart from 'chart.js/auto';

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
    hooks: {
        ChartJS:  {
            dataset() { 
                return JSON.parse(this.el.dataset.points); 
            },
            mounted() {
                const ctx = this.el;
                const transactionsByDay = this.dataset();
                const labels = transactionsByDay.map((t) => t.date);
                const incomes = transactionsByDay.map((t) => t.income);
                const expenses = transactionsByDay.map((t) => t.expense);
                const chart = new Chart(ctx, {
                    type: "bar",
                    data: {
                        labels: labels,
                        datasets: [
                        {
                            label: "Income",
                            data: incomes,
                            backgroundColor: "#4f46e5",
                        },
                        {
                            label: "Expense",
                            data: expenses,
                            backgroundColor: "#F44336",
                        },
                        ],
                    },
                    options: {
                        responsive: true,
                        plugins: {
                        legend: {
                            position: "top",
                        },
                        },
                        scales: {
                        x: {
                            title: {
                            display: true,
                            text: "Date",
                            },
                        },
                        y: {
                            title: {
                            display: true,
                            text: "Amount (USD)",
                            },
                        },
                        },
                    },
                    }
                );
            },
            updated() {
                console.log(this.el)
            }
        }
    },
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken}
})

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

