import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["field"];

  clear() {
    this.eventTarget.value = null;
    window.dispatchEvent(new CustomEvent("search-controller:submit", {}));
  }

  submit(event) {
    event.preventDefault();

    if (event.key === "Enter" || event.type === "click") {
      window.dispatchEvent(new CustomEvent("search-controller:submit", {}));
    }
  }
}
