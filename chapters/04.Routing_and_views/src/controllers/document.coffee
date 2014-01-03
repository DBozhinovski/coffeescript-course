class DocumentController extends Controllers.BaseController
  @init: ->
    super( new Models.DocumentModel(), {
      list: Views.DocumentListView
      item: Views.DocumentItemView
      editor: Views.DocumentEditorView
    })

    @list()

Controllers.DocumentController = DocumentController