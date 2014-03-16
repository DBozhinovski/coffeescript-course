class BaseController
  @init: (model, views) ->
    @model = model
    @views = views

  @list: ->
    listView = new @views.list()
    listView.render @model.all()

  @show: (id) ->
    itemView = new @views.item()
    itemView.render @model.read(id)

  @edit: (id) ->
    editorView = new @views.editor()
    editorView.render @model.read(id)

  @create: (id) ->
    editorView = new @views.editor()
    editorView.render @model.read()

  @update: (record) ->
    @model.update record
    @list

  @store: (record) ->
    record.id = new Date().getTime()
    @model.create record
    @list()

  @delete: (id) ->
    @model.delete id
    @list()


Controllers.BaseController = BaseController