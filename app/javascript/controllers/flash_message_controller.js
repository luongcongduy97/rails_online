import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash-message"
export default class extends Controller {
  static targets = ["flashMessage"]

  connect() {
    this.flashMessageTarget.classList.remove("opacity-0")
    this.flashMessageTarget.classList.add("opacity-100", "transition-opacity", "duration-500")

    this.timeout = setTimeout(() => {
      this.hide()
    }, 5000)
  }

  hide() {
    this.flashMessageTarget.classList.remove("opacity-100")
    this.flashMessageTarget.classList.add("opacity-0")

    this.flashMessageTarget.addEventListener("transitionend", () => {
      this.flashMessageTarget.remove()
    })
  }

  disconnect() {
    clearTimeout(this.timeout)
  }
}
