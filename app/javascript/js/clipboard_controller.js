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
    if (filter && text) {
      const match = new RegExp(filter).exec(text);
      if (match) {
        text = match[0];
      }
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
    if (copiedClass) {
      this.buttonTarget.classList.add(copiedClass);
    }
    const copiedMessage = this.data.get("copiedMessage");
    const content = this.buttonTarget.innerHTML;
    if (copiedMessage) {
      this.buttonTarget.innerHTML = copiedMessage;
    }

    this.timeout = setTimeout(() => {
      this.buttonTarget.classList.remove(copiedClass);
      this.buttonTarget.innerHTML = content;
    }, this.successDuration);
  }
}
