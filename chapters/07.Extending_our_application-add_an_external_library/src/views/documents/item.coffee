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
          <button class='formitem' data-action='edit' data-id='#{doc.id}'>Edit</button>
          <button class='formitem' data-action='export' data-id='#{doc.id}'>Export</button>
          <button class='formitem' data-action='delete' data-id='#{doc.id}'>Delete</button>
          <button class='formitem' data-action='close'>Close</button>
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
        when 'export'
          # Export the document
          doc = new jsPDF

          doc.fromHTML @element.find('article').html(), 20, 20, {
            width: 210,
            height: 297,
            elementHandlers: {}
          }

          link = document.createElement "a"
          link.download = "#{@element.find('h1').text()}.pdf"
          link.href = doc.output 'datauristring'
          link.click()
        when 'delete'
          if confirm("Are you sure?")
            Controllers.DocumentController.delete target.attr 'data-id'
        when 'close'
          @close()


Views.DocumentItemView = DocumentItemView