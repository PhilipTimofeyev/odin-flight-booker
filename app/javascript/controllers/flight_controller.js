import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

	static targets = [ 'target']

	show(event) {
		let dep_airport = event.target.selectedOptions[0].value
		console.log(dep_airport)

		// console.log(this.targetTarget.inner)

		const url = `/flights/show?dep_airport=${dep_airport}`

		Turbo.visit(url)
	}



}