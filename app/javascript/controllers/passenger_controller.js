import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'temp', 'target', 'parent']
  add() {
    let temp = this.tempTarget
    let clon = temp.content.cloneNode(true);
    this.targetTarget.appendChild(clon)
  }
}