import { Controller } from "@hotwired/stimulus";
import { computePosition, flip, shift, offset } from "@floating-ui/dom";

export default class extends Controller {
  static targets = ["clickable", "popover"];

  connect() {
    this.attachEventListeners();
  }

  disconnect() {
    this.removeEventListeners();
  }

  attachEventListeners() {
    this.showPopover = this.showPopover.bind(this);
    this.hidePopover = this.hidePopover.bind(this);

    this.handleClickOutside = this.handleClickOutside.bind(this);
    document.addEventListener("click", this.handleClickOutside);

    [
      ["click", this.showPopover],
      // ["mouseleave", this.hidePopover],
      ["focus", this.showPopover],
      ["blur", this.hidePopover],
    ].forEach(([event, listener]) => {
      this.clickableTarget.addEventListener(event, listener);
    });
  }

  removeEventListeners() {
    if (this.showPopover) {
      this.element.removeEventListener("mouseenter", this.showPopover);
      this.element.removeEventListener("mouseleave", this.hidePopover);
    }
    if (this.handleClickOutside) {
      document.removeEventListener("click", this.handleClickOutside);
    }
  }

  hidePopover() {
    this.popoverTarget.classList.remove("visible");
    this.hidePopover = this.hidePopover.bind(this);
    this.popoverTarget
      .querySelector(".popover-close")
      .removeEventListener("click", () => {
        this.hidePopover();
      });
  }

  showPopover() {
    const clickable = this.clickableTarget;
    const popover = this.popoverTarget;
    this.setupPopoverClose();

    popover.classList.add("visible");

    computePosition(clickable, popover, {
      placement: "bottom",
      middleware: [offset(16), flip(), shift({ padding: 5 })],
    }).then(({ x, y }) => {
      Object.assign(popover.style, {
        left: `${x}px`,
        top: `${y}px`,
      });
    });
  }

  setupPopoverClose() {
    this.hidePopover = this.hidePopover.bind(this);
    this.popoverTarget
      .querySelector(".popover-close")
      .addEventListener("click", () => {
        this.hidePopover();
      });
  }

  handleClickOutside(event) {
    const popover = this.popoverTarget;
    if (
      popover.classList.contains("visible") &&
      !popover.contains(event.target) &&
      !this.clickableTarget.contains(event.target)
    ) {
      this.hidePopover();
    }
  }
}
