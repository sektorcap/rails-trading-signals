# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $(".select2").select2({
    placeholder: "Seleziona un'azione",
    allowClear: true,
    maximumSelectionLength: 1
  })

  t = $('table#portfolio')
  table = t.DataTable( {
      destroy: true
      autoWidth: false
      responsive: true
      stateSave: true
      aLengthMenu: [ 50, 100, 200, 500, 1000 ]
      dom: 'Bfrtlip'
      # dom: 'Blfrtip'
      # dom: "<'row'<'col-sm-12 col-md-6'B><'col-sm-12 col-md-2'l><'col-sm-12 col-md-4'f>><'row'<'col-sm-12'tr>><'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>"
      # dom: "<'row'<'col-sm-12 col-md-12'B>><'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>><'row'<'col-sm-12'tr>><'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>"

      buttons: [
        {
          text: 'Posizioni Aperte',
          action: ( e, dt, node, config ) ->
              dt.columns(6).search("aperta").draw();
        }
        {
          text: 'Posizioni Chiuse',
          action: ( e, dt, node, config ) ->
              dt.columns(6).search("chiusa").draw();
        }
        {
          text: 'Tutte le posizioni',
          action: ( e, dt, node, config ) ->
              dt.columns(6).search("").draw();
        }
      ]
  })

  document.addEventListener 'turbolinks:before-cache', ->
    table.destroy()
