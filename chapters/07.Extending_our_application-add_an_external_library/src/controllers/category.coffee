class CategoryController extends Controllers.BaseController
  @init: =>
    super( new Models.CategoryModel(), {
      list: Views.CategoryListView
    })

    EventEmitter.on "category:update", (record) => @update record
    EventEmitter.on "category:store", (record) => @store record


Controllers.CategoryController = CategoryController