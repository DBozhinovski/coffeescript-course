class Router
  @routes:
    'documents': Controllers.DocumentController.list
    'document/show': Controllers.DocumentController.show
    'document/edit': Controllers.DocumentController.edit
    'document/new': Controllers.DocumentController.create

    'categories': Controllers.CategoryController.list

  @call: (route, parameters...) ->
    @routes[route].call @context(route), if parameters > 0 then parameters else false

  @context: (route) ->
    contexts = 
      "document": Controllers.DocumentController
      "documents": Controllers.DocumentController
      "category": Controllers.CategoryController
      "categories": Controllers.CategoryController

    contexts[route.split("/")[0]]

@Router = Router