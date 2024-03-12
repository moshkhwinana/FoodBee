import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-product"
export default class extends Controller {
  static targets = ['info', 'form']
  connect() {
  }
}
