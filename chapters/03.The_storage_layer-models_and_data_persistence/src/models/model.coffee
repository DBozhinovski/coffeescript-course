class Model
  constructor:(@key) ->
    @data = JSON.parse Storage.get(@key)

  @all: ->
    @data

  create: (record) ->
    unless @data[record.id]
      @data[record.id] = record
      @persist()
      return true

    false

  @read: (id) ->
    return @data[id] if @data[id]
    false

  update: (record) ->
    if @data[record.id]
      @data[record.id] = record
      @persist()
      return true

    false

  @delete: (id) ->
    if @data[id]
      @data[id] = null
      delete @data[id]
      @persist()
      return true

    false

  @persist: ->
    Storage.set @key, @data

@Model = Model
