class Router
  @routes:
    'documents': Controllers.DocumentController.list
    'document/show': Controllers.DocumentController.show
    'document/edit': Controllers.DocumentController.edit
    'document/new': Controllers.DocumentController.create

    # 'categories': Controllers.CategoryController.list
    # 'category/show': Controllers.CategoryController.show
    # 'category/edit': Controllers.CategoryController.edit
    # 'category/new': Controllers.CategoryController.create

  @call: (route, parameters...) ->
    @routes[route].call @context(route), parameters

  @context: (route) ->
    contexts = 
      "document": Controllers.DocumentController
      "documents": Controllers.DocumentController
      "category": Controllers.CategoryController
      "categories": Controllers.CategoryController

    contexts[route.split("/")[0]]

@Router = Router