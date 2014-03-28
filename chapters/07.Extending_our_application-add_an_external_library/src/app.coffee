@Models = {}
@Controllers = {}
@Views = {}

$ ->
  Controllers.DocumentController.init()
  Controllers.CategoryController.init()

  $("#sidebar a").on "click", (event) ->
    event.preventDefault()
    route = $(event.currentTarget).attr "href"
    
    Router.call route