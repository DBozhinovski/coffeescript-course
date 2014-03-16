class DocumentItemView extends Views.BaseView
  constructor: ->
    super $("#canvas"), (doc) ->
      "
        <article>
          <h1>#{doc.title}</h1>
          #{doc.content}
        </article>
        <div class='category'>#{doc.category}</div>
        <div class='actions'>
          <button data-action='edit' data-id='#{doc.id}'>Edit</button>
          <button data-action='delete' data-id='#{doc.id}'>Delete</button>
          <button data-action='close'>Close</button>
        </div>
      "

  render: (data) ->
    super data
    @bind()

  close: ->
    @element.find('button').off 'click'
    Router.call "documents"

  bind: ->
    @element.find('button').on 'click', (event) =>
      target = $ event.currentTarget
      action = target.attr 'data-action'

      switch action
        when 'edit'
          Controllers.DocumentController.edit target.attr 'data-id'
        when 'delete'
          if confirm("Are you sure?")
            Controllers.DocumentController.delete target.attr 'data-id'
        when 'close'
          @close()


Views.DocumentItemView = DocumentItemView