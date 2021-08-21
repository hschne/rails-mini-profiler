import '../stylesheets/rails-mini-profiler.scss'

import tippy from 'tippy.js'
import 'tippy.js/dist/tippy.css'

function setupRequestSearch() {
  const profiledRequestNameSearch = document.getElementById('profiled-request-search')
  if (profiledRequestNameSearch) {
    profiledRequestNameSearch.addEventListener('keyup', function (event) {
      if (event.key === 'Enter') {
        event.preventDefault()
        document.getElementById('profiled-request-search-form').submit()
      }
    })
  }
}

function setupTraceSearch() {
  const traceNameSearch = document.getElementById('trace-search')
  if (traceNameSearch) {
    traceNameSearch.addEventListener('keyup', function (event) {
      if (event.key === 'Enter') {
        event.preventDefault()
        document.getElementById('trace-form').submit()
      }
    })
  }
}

function setupRequestTable() {
  const profiledRequestTable = document.getElementById('profiled-requests-table');
  if (profiledRequestTable) {
    const rows = profiledRequestTable.getElementsByTagName('tr')
    for (let i = 0; i < rows.length; i++) {
      const currentRow = profiledRequestTable.rows[i]
      const link = currentRow.dataset.link
      const createClickHandler = function () {
        return function () {
          window.location.href = link
        }
      }
      currentRow.onclick = createClickHandler(currentRow)
    }
  }
}

function setupTraceBars () {
  const traceBars = document.querySelectorAll('.trace-bar')
  traceBars.forEach((bar) => {
    const popover = bar.children[0]
    tippy(bar, {
      trigger: 'click',
      content: popover,
      theme: 'rmp',
      maxWidth: '700px',
      placement: 'bottom',
      interactive: true,
      onShow (instance) {
        instance.popper.querySelector('.popover-close').addEventListener('click', () => {
          instance.hide()
        })
      },
      onHide (instance) {
        instance.popper.querySelector('.popover-close').removeEventListener('click', () => {
          instance.hide()
        })
      },
    })
  })
}


// Trace Bar Popovers
document.addEventListener('DOMContentLoaded', () => {
  setupRequestTable();
  setupRequestSearch();
  setupTraceBars();
  setupTraceSearch();
}, false)

