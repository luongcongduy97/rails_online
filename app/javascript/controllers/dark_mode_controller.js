import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggle"];

  connect() {
    this.loadDarkModePreference();
    this.toggleTarget.addEventListener("click", this.toggleDarkMode.bind(this));
  }

  toggleDarkMode() {
    document.documentElement.classList.toggle('dark');
    this.saveDarkModePreference();
  }

  loadDarkModePreference() {
    const darkMode = localStorage.getItem('dark-mode');
    if (darkMode === 'enabled') {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  }

  saveDarkModePreference() {
    const isDarkMode = document.documentElement.classList.contains('dark');
    localStorage.setItem('dark-mode', isDarkMode ? 'enabled' : 'disabled');
  }

  disconnect() {
    this.toggleTarget.removeEventListener("click", this.toggleDarkMode);
  }
}
