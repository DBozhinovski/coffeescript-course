class CategoryListView extends Views.BaseView
  constructor: ->
    super $("#canvas"), (data) ->
        output = "<ul class='categories'>"

        for id, item of data
          output += "
            <li data-id='#{item.id}'>
              <div class='title'>#{item.title}</div>
            </li>
          "
        output += "</ul>"

        output

  render: (data) ->
    super data
    @bind()

  bind: ->
    @element.find('li').on 'click', (event) ->
      name = $(event.currentTarget).text()
      EventEmitter.trigger 'document:filter', name.trim()

Views.CategoryListView = CategoryListView
