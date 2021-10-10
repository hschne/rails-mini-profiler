import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "source"];

  connect() {
    if (!this.hasButtonTarget) return;

    this.originalText = this.buttonTarget.innerText;
    this.successDuration = 2000;
  }

  copy(event) {
    event.preventDefault();

    let text = this.sourceTarget.innerText;
    const filter = this.data.get("filter");
    if (filter) {
      text = new RegExp(filter).exec(text)[0];
    }
    const temporaryInput = document.createElement("textarea");
    temporaryInput.value = text;
    document.body.appendChild(temporaryInput);
    temporaryInput.select();
    document.execCommand("copy");
    document.body.removeChild(temporaryInput);

    this.copied();
  }

  copied() {
    if (!this.hasButtonTarget) return;

    if (this.timeout) {
      clearTimeout(this.timeout);
    }

    const copiedClass = this.data.get("copiedClass");
    console.log(copiedClass);
    this.buttonTarget.classList.add(copiedClass);

    this.timeout = setTimeout(() => {
      this.buttonTarget.classList.remove(copiedClass);
    }, this.successDuration);
  }
}
