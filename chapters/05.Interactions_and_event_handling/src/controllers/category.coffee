class CategoryController extends Controllers.BaseController
  @init: =>
    super( new Models.CategoryModel(), {
      list: Views.CategoryListView
      item: Views.CategoryItemView
      editor: Views.CategoryEditorView
    })

Controllers.CategoryController = CategoryController