class DocumentModel extends Models.BaseModel
  constructor: ->
    super "document"

  getByCategory: (category) ->
    filtered = {}
    for id of @data
      if @data[id].category is category
        filtered[id] = @data[id]

    filtered
  

Models.DocumentModel = DocumentModel