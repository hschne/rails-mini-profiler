import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ["selectable"];

  checkAll(event) {
    const checked = event.target.checked;
    this.setAllCheckboxes(checked);
  }

  checkNone() {
    this.setAllCheckboxes(false);
  }

  setAllCheckboxes(checked) {
    this.selectables.forEach((el) => {
      const checkbox = el;

      if (!checkbox.disabled) {
        checkbox.checked = checked;
      }
    });
  }


  get selectables() {
    return new Array(...this.selectableTargets);
  }
}
