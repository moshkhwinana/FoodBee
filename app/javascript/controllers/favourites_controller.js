import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favourites"
export default class extends Controller {
  connect() {
    console.log('hi')
  }
  toggle() {
    this.element.classList.add("favourited")
  }
}
