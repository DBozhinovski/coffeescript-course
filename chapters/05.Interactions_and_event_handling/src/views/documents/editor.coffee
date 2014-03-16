class DocumentEditorView extends Views.BaseView
  constructor: ->
    super $("#canvas"), (doc = false) =>
      output = "
        <label>title</label>
        <input type='text' name='title' />

        <label>content</label>
        <textarea name='content'></textarea>

        <label>category</label>
        <input type='text' name='category' />

        <div class='actions'>
          <button data-action='save'>save</button>
          <button data-action='close'>cancel</button>
        </div>
      "

      if doc
        $output = $("<div>")
        $output.html(output)
        $output.find("input[name='title']").val doc.title
        $output.find("textarea").val doc.content
        $output.find("input[name='category']").val doc.category
        @id = doc.id
        @mode = 'update'
        output = $output
      else
        @mode = 'create'

      output

  render: (doc) ->
    super doc
    @bind()

  close: ->
    @element.find('button').off 'click'
    Router.call "documents"

  bind: ->
    @element.find('button').on 'click', (event) =>
      target = $ event.currentTarget
      action = target.attr 'data-action'

      switch action
        when "save"
          record = 
            title: @element.find("input[name='title']").val()
            content: @element.find("textarea").val()
            category: @element.find("input[name='category']").val()

          if @mode is 'update'
            record.id = @id
            EventEmitter.trigger 'document:update', record
          else
            EventEmitter.trigger 'document:store', record

          @close()
          alert "Document saved"

        when "close"
          @close()

Views.DocumentEditorView = DocumentEditorView