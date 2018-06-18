# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', (event) ->
  t = $('table#checks')
  table = t.DataTable( {
      destroy: true,
      autoWidth: false,
      responsive: true,
      order: [[1,'desc']]
  })
  document.addEventListener 'turbolinks:before-cache', ->
    table.destroy()
