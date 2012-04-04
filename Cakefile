{spawn, exec} = require 'child_process'
task 'doc', 'rebuild the Docco documentation', ->
  exec([
    'rm -r docs'
    'node_modules/docco/bin/docco automan.js.coffee'
  ].join(' && '), (err) ->
    throw err if err
  )
