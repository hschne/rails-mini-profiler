import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["enable"];

  enable() {
    this.enableTarget.disabled = false;
  }

  disable() {
    this.enableTarget.disabled = true;
  }

  hide() {}
}
