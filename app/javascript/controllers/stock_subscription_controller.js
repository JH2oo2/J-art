import { Controller } from "@hotwired/stimulus"
import { application } from "./application";
import { createConsumer } from "@rails/actioncable"
// import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="stock-subscription"
export default class extends Controller {
  connect() {
    // console.log('Connected to stock subscription controller');
    // console.log(this.dashboardIdValue);
    //   this.channel = createConsumer("wss://finnhub.io?token=cl02ofpr01qhjei31750cl02ofpr01qhjei3175g").subscriptions.create(
    //     {channel: 'DashboardChannel',id: this.dashboardIdValue},
    //     {received: data => {
    //       console.log(data);
    //       console.log(this.dashboardIdValue);


    //     }
    //   })

    const socket = new WebSocket('wss://ws.finnhub.io?token=cl02ofpr01qhjei31750cl02ofpr01qhjei3175g');


    // Connection opened -> Subscribe
    const symbol = document.querySelectorAll('.stockIndex')
    // console.log(symbol);
    symbol.forEach((stock) => {
      socket.addEventListener('open', function (event) {
        socket.send(JSON.stringify({'type':'subscribe', 'symbol': stock.innerText}))
        // console.log(stock.innerText);

        // socket.addEventListener('open', function (event) {
          //     socket.send(JSON.stringify({'type':'subscribe', 'symbol': 'AAPL'}))
          // });
          // Listen for messages
        })
      });



    const url = '/api';
    fetch(url)
      .then(response => response.json())
      .then((data) => {
        data.forEach((stockData) => {
          console.log(stockData);
          let stockId = stockData.id
          console.log(stockId);

          symbol.forEach((stock) => {
            socket.addEventListener('message', function (event) {
              const data = event.data;
              let myData = JSON.parse(data)
              const newPrice = myData.data[0].p;
              // const oldPrice = stock.innerText;
              // console.log(myData.data);
              // console.log(newPrice);
              // console.log(oldPrice);
              // const stockDataDiv = document.querySelector('.stockIndex');
              if (stock.innerText === myData.data[0].s) {
                stock.innerText = `${myData.data[0].s} ${myData.data[0].p}`;
                const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
                fetch(`/update_stock_price/${stockId}`, {
                  method: 'POST',
                  headers: { 'Content-Type': 'application/json',
                  'X-CSRF-Token': csrfToken },
                  body: JSON.stringify({ stock: {price: newPrice } })
                })
                .then(response => response.json())
                .then((data) => {
                  console.log(data);
                  // console.log(stockDataDiv);
                  // stockDataDiv.innerText = `${data.symbol} ${data.price}`;
                });
              }
            })
          });
        });

      });





    }
}
