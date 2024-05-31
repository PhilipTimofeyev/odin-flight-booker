import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  greet() {
    console.log("lol")
    // this.element.textContent = "Hello World!"
  }
}
