class DocumentController extends Controllers.BaseController
  @init: =>
    super( new Models.DocumentModel(), {
      list: Views.DocumentListView
      item: Views.DocumentItemView
      editor: Views.DocumentEditorView
    })

    EventEmitter.on "document:update", (record) => @update record
    EventEmitter.on "document:store", (record) => @store record
    EventEmitter.on "document:show", (id) => @show id

    EventEmitter.on "document:filter", (category) =>
      @list(category)

    @list()

  @list: (category) ->
    if category
      listView = new @views.list()
      listView.render @model.getByCategory(category), category
    else
      super()

Controllers.DocumentController = DocumentController