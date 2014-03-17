class DocumentListView extends Views.BaseView
  constructor: ->
    super $("#canvas"), (data) ->
      output = "<h1 class='category-title'></h1>"
      output += "<ul class='documents'>"
      for id, item of data
        output += "
          <li data-id='#{item.id}'>
            <img src='assets/document.png' />
            <div class='title'>#{item.title}</div>
          </li>
        "
      output += "</ul><div class='clear'></div>"

      output

  render: (data, category = false) ->
    super data
    $('.category-title').text(category) if category
    @bind()

  bind: ->
    @element.find('li').on 'click', (event) ->
      id = $(event.currentTarget).attr "data-id"
      EventEmitter.trigger "document:show", id

Views.DocumentListView = DocumentListView
