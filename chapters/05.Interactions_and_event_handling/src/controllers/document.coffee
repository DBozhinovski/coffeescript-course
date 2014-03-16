class DocumentController extends Controllers.BaseController
  @init: =>
    super( new Models.DocumentModel(), {
      list: Views.DocumentListView
      item: Views.DocumentItemView
      editor: Views.DocumentEditorView
    })

    EventEmitter.on "document:update", (record) => @update record
    EventEmitter.on "document:store", (record) => @store record

    @list()

Controllers.DocumentController = DocumentController