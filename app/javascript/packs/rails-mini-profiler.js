import "../stylesheets/rails-mini-profiler.scss";

import { Application } from "@hotwired/stimulus";
import { Dropdown } from "tailwindcss-stimulus-components";
import Checklist from "../js/checklist_controller";
import Selectable from "../js/select_controller";
import Filter from "../js/filter_controller";
import Search from "../js/search_controller";
import Enable from "../js/enable_controller";
import Clipboard from "../js/clipboard_controller";
import Popover from "../js/popover_controller.js";

const application = Application.start();

application.register("dropdown", Dropdown);
application.register("checklist", Checklist);
application.register("selectable", Selectable);
application.register("filters", Filter);
application.register("search", Search);
application.register("enable", Enable);
application.register("clipboard", Clipboard);
application.register("popover", Popover);

function setupTraceSearch() {
  const traceNameSearch = document.getElementById("trace-search");
  if (traceNameSearch) {
    traceNameSearch.addEventListener("keyup", function (event) {
      if (event.key === "Enter") {
        event.preventDefault();
        document.getElementById("trace-form").submit();
      }
    });
  }
}

function setupRequestTable() {
  const profiledRequestTable = document.getElementById(
    "profiled-requests-table"
  );
  if (profiledRequestTable) {
    const rows = profiledRequestTable.rows;
    for (let i = 1; i < rows.length; i++) {
      const currentRow = profiledRequestTable.rows[i];
      const link = currentRow.dataset.link;
      const createClickHandler = function () {
        return function () {
          window.location.href = link;
        };
      };
      if (link) {
        currentRow.onclick = createClickHandler(currentRow);
      }
    }
  }
}

// Trace Bar Popovers
document.addEventListener(
  "DOMContentLoaded",
  () => {
    setupRequestTable();
    setupTraceSearch();
  },
  false
);
