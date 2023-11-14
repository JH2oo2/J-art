import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="stocks"
export default class extends Controller {
  connect() {
    // console.log("Hello, Stimulus!")

    const apiKey = window.API_KEY;
    console.log(apiKey)


  }
}
