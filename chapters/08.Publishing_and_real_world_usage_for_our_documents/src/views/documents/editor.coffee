class DocumentEditorView extends Views.BaseView
  constructor: ->
    super $("#canvas"), (doc = false) =>
      output = "
        <label class='formitem'>title</label>
        <input class='formitem' type='text' name='title' />

        <label class='formitem'>content</label>
        <div class='formitem' name='content'></div>

        <label class='formitem'>category</label>
        <select class='formitem' name='category'></select><button class='formitem add' data-action='add-category'>+</button>

        <div class='actions'>
          <button class='formitem' data-action='save'>save</button>
          <button class='formitem' data-action='close'>cancel</button>
        </div>
      "

      $output = $("<div class='form'>")
      $output.html(output)

      $output.find("[name=content]").summernote {
        height: 400
      }

      if doc
        $output.find("input[name='title']").val doc.title
        $output.find("[name='content']").code doc.content
        $output.find("[name='category']").val doc.category
        @id = doc.id
        @mode = 'update'
        output = $output
      else
        @mode = 'create'

      $output

  render: (doc) ->
    super doc
    categories = new Models.CategoryModel().all()
    for id of categories
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
            content: @element.find("[name='content']").code()
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