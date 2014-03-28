wordpress = require "wordpress"
http = require "http"
qs = require "querystring"

wp = wordpress.createClient {
  url: 'http://dbozhinovski.wordpress.com/'
  username: "dbozhinovski"
  password: "yormungander"
}

server = http.createServer (request, response) ->
  if request.method is "POST"
    requestData = ""
    
    request.on 'data', (data) ->
      requestData += data

    request.on 'end', ->
      formData = qs.parse requestData
      
      wp.newPost {
        title: formData['title']
        status: 'publish'
        content: formData['content']
        author: 'dbozhinovski'
      }, ->

        response.writeHead 200, {
          'Content-Type': 'text/html',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Headers': 'X-Requested-With'
          'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE'
        }
        response.end 'OK'

server.listen(8080)