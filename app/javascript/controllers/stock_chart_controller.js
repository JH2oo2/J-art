import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="stock-chart"
export default class extends Controller {
  connect() {
    const symbol = document.querySelector('#index')
    console.log(symbol.innerText);

    const url = `https://finnhub.io/api/v1/stock/candle?symbol=${symbol.innerText}&resolution=D&count=30&token=cl02ofpr01qhjei31750cl02ofpr01qhjei3175g`;
    fetch(url)
      .then(response => response.json())
      .then((data) => {
        createChart(data);
      })
      .catch((error) => {
        console.error('Error:', error);
      });

    function createChart(data) {
      console.log(data);
      const dates = data.t.map((date) => {
        return new Date(date * 1000).toLocaleDateString();
      });
      const prices = data.c;
      const ctx = document.getElementById('stockChart').getContext('2d');
      new Chart (ctx, {
        type: 'line',
        data: {
          labels: dates,
          datasets: [{
            label: 'Stock Price',
            data: prices,
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            borderColor: 'rgba(255, 99, 132, 1)'
          }]
        },
        options: {
          scales: {
            yAxes: {
              ticks: {
                beginAtZero: false
              }
            }
          }
        }
      })

    }

  }
}
