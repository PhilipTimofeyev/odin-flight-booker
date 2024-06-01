import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'temp', 'target', 'parent', 'id']
  static values = { count: 1}

  add() {
    let temp = this.tempTarget.content.firstChild.nextSibling;
    let tempClone = temp.cloneNode(true);

    this.countValue++

    let newId = this.countValue

    let toReplaceEmailname = tempClone.lastElementChild.name
    tempClone.lastElementChild.name = toReplaceEmailname.replace( /\d/g, newId)

    let toReplaceNameName = tempClone.firstElementChild.nextSibling.nextSibling.name
    tempClone.firstElementChild.nextSibling.nextSibling.name = toReplaceNameName.replace( /\d/g, newId)

    this.targetTarget.appendChild(tempClone)
  }

  remove() {
    let last = this.targetTarget.firstChild

    if (last == null) {
      alert("At least one passenger is required.")
    } else {
      last.remove(last)
    }
  }
}