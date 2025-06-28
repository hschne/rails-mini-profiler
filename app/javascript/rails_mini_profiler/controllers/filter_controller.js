import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["filter"];

  apply() {
    location.href = `${window.location.pathname}?${this.params}`;
  }

  reset() {
    location.href = `${window.location.pathname}`;
  }

  post() {
    const token = document.head.querySelector(
      'meta[name="csrf-token"]'
    ).content;
    const path = `${window.location.pathname}/destroy_all?${this.params}`;
    fetch(path, {
      method: "DELETE",
      redirect: "follow",
      headers: {
        "Content-Type": "application/json",
        credentials: "same-origin",
      },
      body: JSON.stringify({ authenticity_token: token }),
    }).then((response) => {
      if (response.redirected) {
        window.location.href = response.url;
      }
    });
  }

  get params() {
    return this.activeFilterTargets()
      .map((t) => `${t.name}=${t.value}`)
      .join("&");
  }

  activeFilterTargets() {
    return this.filterTargets.filter(function (target) {
      if (target.type === "checkbox" || target.type === "radio")
        return target.checked;

      return target.value.length > 0;
    });
  }
}
