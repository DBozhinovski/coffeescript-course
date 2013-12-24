class Storage
  @get: (key) ->
    localStorage.getItem JSON.parse(key)

  @set: (key, value) ->
    localStorage.setItem key, JSON.stringify(value)

@Storage = Storage
