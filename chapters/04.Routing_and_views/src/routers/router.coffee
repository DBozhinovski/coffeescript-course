class Router
  @routes:
    'documents': Controllers.DocumentController.list
    'document/show': Controllers.DocumentController.show
    'document/edit': Controllers.DocumentController.edit
    'document/new': Controllers.DocumentController.create

    'categories': CategoryController.list
    'category/show': CategoryController.show
    'category/edit': CategoryController.edit
    'category/new': CategoryController.create
    'category/delete': CategoryController.delete

  @call: (route, parameters...) ->
    @routes[route](parameters)

@Router = Router