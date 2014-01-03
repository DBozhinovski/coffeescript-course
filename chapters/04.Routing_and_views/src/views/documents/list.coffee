class DocumentListView extends Views.BaseView
  constructor: ->
    super $("#canvas"), (data) ->
      output = "<ul class='documents'>"
      for id, item of data
        output += "
          <li data-id='#{item.id}'>
            <img src='assets/document.png' />
            <div class='title'>#{item.title}</div>
          </li>
        "
      output += "</ul><div class='clear'></div>"

      output

  render: (data) ->
    super data
    @bind()

  bind: ->
    @element.find('li').on 'click', (event) ->
      id = $(event.currentTarget).attr "data-id"
      Controllers.DocumentController.show id


Views.DocumentListView = DocumentListView
