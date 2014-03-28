class DocumentItemView extends Views.BaseView
  constructor: ->
    super $("#canvas"), (doc) ->
      "
        <article>
          <h1>#{doc.title}</h1>
          #{doc.content}
        </article>
        <div class='category'>#{doc.category}</div>
        <div class='form actions'>
          <button class='formitem' data-action='edit' data-id='#{doc.id}'>Edit</button>
          <button class='formitem' data-action='export-pdf' data-id='#{doc.id}'>Export (PDF)</button>
          <button class='formitem' data-action='export-text' data-id='#{doc.id}'>Export (Text)</button>
          <button class='formitem' data-action='export-html' data-id='#{doc.id}'>Export (HTML)</button>
          <button class='formitem' data-action='publish' data-id='#{doc.id}'>Publish</button>
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
        when 'export-pdf'
          doc = new jsPDF

          doc.fromHTML @element.find('article').html(), 20, 20, {
            width: 1024,
            elementHandlers: {}
          }

          link = document.createElement "a"
          link.download = "#{@element.find('h1').text()}.pdf"
          link.href = doc.output 'datauristring'
          link.click()
        when 'export-text'
          text = @element.find('article').text()
          file = new Blob [text], { type: 'text/plain' }

          link = document.createElement "a"
          link.download = "#{@element.find('h1').text()}.txt"
          link.href = URL.createObjectURL file
          link.click()
        when 'export-html'
          text = @element.find('article').html()
          file = new Blob [text], { type: 'text/html' }

          link = document.createElement "a"
          link.download = "#{@element.find('h1').text()}.html"
          link.href = URL.createObjectURL file
          link.click()
        when 'publish'
          title = @element.find('h1').text()
          content = @element.find('article').html()

          $.post 'http://localhost:8080', { title: title, content: content }, (response) ->
            alert 'published'
            Router.call 'documents'
        when 'delete'
          if confirm("Are you sure?")
            Controllers.DocumentController.delete target.attr 'data-id'
        when 'close'
          @close()


Views.DocumentItemView = DocumentItemView