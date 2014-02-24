@Models = {}
@Controllers = {}
@Views = {}

$ ->
  $("#sidebar a").on "click", (event) ->
    event.preventDefault()
    route = $(event.currentTarget).attr "href"
    
    Router.call route