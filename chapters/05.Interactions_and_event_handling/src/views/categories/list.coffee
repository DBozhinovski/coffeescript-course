class CategoryListView extends Views.BaseView
  constructor: ->
    super $("#canvas"), (data) ->
      output = "<div>Categories</div>"
      console.log data

      output

  render: (data) ->
    super data
    @bind()

  bind: ->


Views.CategoryListView = CategoryListView
