$(document).on 'turbolinks:load', ->
  return unless $(".home.index").length > 0
  $('input#search').autocomplete
    serviceUrl: '/search'
    maxHeight: 'auto'
    width: '500px'
    autoSelectFirst: true
    onSelect: (suggestion) ->
      $('input#search').val('')
      $.ajax
        url: '/save'
        method: "POST"
        data:
          id: suggestion.data
  return
