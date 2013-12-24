class Storage
  @get: (key) ->
    JSON.parse localStorage.getItem(key)

  @set: (key, value) ->
    localStorage.setItem key, JSON.stringify(value)

@Storage = Storage
