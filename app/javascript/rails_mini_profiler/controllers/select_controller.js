import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["all", "selectable"];

  selectAll(event) {
    const checked = event.target.checked;
    this.allTarget.indeterminate = false;
    this._setAllCheckboxes(checked);
    this._dispatch("change", { count: this.selectedCount });
  }

  onSelected() {
    this.allTarget.indeterminate = !!this._indeterminate;
    this._dispatch("change", { count: this.selectedCount });
  }

  get selectedCount() {
    return this.selected.length;
  }

  get selected() {
    return this.selectables.filter((c) => c.checked);
  }

  get selectables() {
    return new Array(...this.selectableTargets);
  }

  _setAllCheckboxes(checked) {
    this.selectables.forEach((el) => {
      const checkbox = el;

      if (!checkbox.disabled) {
        checkbox.checked = checked;
      }
    });
  }

  get _indeterminate() {
    return (
      this.selected.length !== this.selectableTargets.length &&
      this.selected.length > 0
    );
  }

  _dispatch(name, detail) {
    window.dispatchEvent(
      new CustomEvent(`rmp:select:${name}`, { bubbles: true, detail })
    );
  }
}
