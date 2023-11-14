import { Controller } from "@hotwired/stimulus"
import { application } from "./application";
import { createConsumer } from "@rails/actioncable"
// import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="stock-subscription"
export default class extends Controller {
  connect() {
    // console.log('Connected to stock subscription controller');
      // **** FIX *** the below code, token should not be hardcoded
    const socket = new WebSocket('wss://ws.finnhub.io?token=cl02ofpr01qhjei31750cl02ofpr01qhjei3175g');
    // Connection opened -> Subscribe
    const symbol = document.querySelectorAll('.stockIndex')
    // console.log(symbol);
    symbol.forEach((stock) => {
      socket.addEventListener('open', function (event) {
        socket.send(JSON.stringify({'type':'subscribe', 'symbol': stock.innerText}))
        })
      });
    symbol.forEach((stock) => {
      socket.addEventListener('message', function (event) {
        const data = event.data;
        let myData = JSON.parse(data)
        const newPrice = myData.data[0].p;
        // stockDataDiv = document.querySelector('.stockIndex');
        if (stock.innerText === myData.data[0].s) {
          stock.innerText = `${myData.data[0].s} ${myData.data[0].p}`;
          const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
          fetch(`/update_stock_price/${myData.data[0].s}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json',
            'X-CSRF-Token': csrfToken },
            body: JSON.stringify({ stock: {price: newPrice } })
          })
        }
      });

    });





  }
}
