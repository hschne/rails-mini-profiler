import "@hotwired/turbo-rails";
import "controllers";

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
