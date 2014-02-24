{exec, spawn} = require "child_process"

# watches files for changes, and compiles them to a single file
task 'watch', 'live compile', ->
  source = spawn "coffee", ["-w","--join", "dist/app.js", "-c", "src"] # Watch for changes in the source dir

  source.stdout.on "data", (stdout) ->
    console.log stdout.toString().trim()

  source.stdout.on "error", (error) ->
    console.log stdout.toString().trim()

task 'compile', 'compile', ->
  exec "coffee --join dist/app.js -c src", ->
    console.log 'Done'