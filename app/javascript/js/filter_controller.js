import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["filter"];

  apply() {
    location.href =  `${window.location.pathname}?${this.params}`;
  }

  get params() {
    console.log(this.activeFilterTargets())
    return this.activeFilterTargets()
      .filter(t => t.value.length > 0)
      .map((t) => `${t.name}=${t.value}`).join("&");
  }

  activeFilterTargets() {
    return this.filterTargets
      .filter(function(target) {
        if (target.type === 'checkbox' || target.type === 'radio') return target.checked;

        return true
      })
  }
}
