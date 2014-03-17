class DocumentEditorView extends Views.BaseView
  constructor: ->
    super $("#canvas"), (doc = false) =>
      output = "
        <label>title</label>
        <input type='text' name='title' />

        <label>content</label>
        <textarea name='content'></textarea>

        <label>category</label>
        <select name='category'></select><button data-action='add-category'>+</button>

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
        $output.find("[name='category']").val doc.category
        @id = doc.id
        @mode = 'update'
        output = $output
      else
        @mode = 'create'

      output

  render: (doc) ->
    super doc
    categories = new Models.CategoryModel().all()
    console.log categories
    for id of categories
      console.log categories[id].title
      $("select[name='category']").append("<option>#{categories[id].title}</option")
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
            category: @element.find("[name='category']").val()

          if @mode is 'update'
            record.id = @id
            EventEmitter.trigger 'document:update', record
          else
            EventEmitter.trigger 'document:store', record

          if @categoryMode is 'add'
            EventEmitter.trigger 'category:store', { title: record.category }

          @close()
          alert "Document saved"
        when "add-category"
          select = $("select[name='category']")
          textbox = $("<input name='category' />")

          select.replaceWith textbox
          $("button[data-action='add-category']").remove()
          @categoryMode = 'add'
        when "close"
          @close()

Views.DocumentEditorView = DocumentEditorView