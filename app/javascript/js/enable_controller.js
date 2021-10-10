import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["enable"];

  enable() {
    this.enableTarget.disabled = false;
  }

  disable() {
    this.enableTarget.disabled = true;
  }

  change(event) {
    if (event.type.match(/rmp:select:.*/)) {
      if (event.detail.count > 0) {
        this.enable();
      } else {
        this.disable();
      }
    }
  }
}
