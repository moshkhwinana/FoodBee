import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-new-recipe"
export default class extends Controller {
  static targets = [ "button", "input" ]

  connect() {
    console.log('new recipe controller')
    console.log(this.inputTargets)
  }

  show() {
    console.log('show')
    if (this.inputTargets.some(input => input.checked)) {
      this.buttonTarget.classList.remove('d-none')
    } else {
      this.buttonTarget.classList.add('d-none')
    }
  }
}
