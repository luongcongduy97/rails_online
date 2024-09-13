// app/javascript/controllers/company_selection_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["companyFields"]

  connect() {
    console.log("Stimulus controller connected");
  }

  toggleFields(event) {
    const selectedValue = event.target.value;
    if (selectedValue === 'new') {
      this.companyFieldsTarget.style.display = 'block';
    } else {
      this.companyFieldsTarget.style.display = 'none';
    }
  }
}
