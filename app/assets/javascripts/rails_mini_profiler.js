// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require_tree .

const profiledRequestNameSearch = document.getElementById('profiled-request-search')
if (profiledRequestNameSearch) {
  profiledRequestNameSearch.addEventListener('keyup', function (event) {
    if (event.key === 'Enter') {
      event.preventDefault()
      document.getElementById('profiled-request-search-form').submit()
    }
  })
}

const traceNameSearch = document.getElementById('trace-search')
if (profiledRequestNameSearch) {
  profiledRequestNameSearch.addEventListener('keyup', function (event) {
    if (event.key === 'Enter') {
      event.preventDefault()
      document.getElementById('trace-form').submit()
    }
  })
}

document.addEventListener('DOMContentLoaded', () => {
  const traceBars = document.querySelectorAll('.trace-bar');
  traceBars.forEach((bar) => {
    const popover = bar.children[0];
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
}, false);

