{spawn, exec}     = require 'child_process'
{print}           = require 'util'
util              = require 'util'
fs                = require 'fs'
{parser, uglify}  = require 'uglify-js'
CoffeeScript      = require 'coffee-script'

task 'doc', 'rebuild the Docco documentation', ->
  util.print "Documenting...\n"
  exec([
    'rm -r docs'
    'node_modules/docco/bin/docco automan.js'
  ].join(' && '), (err) ->
    throw err if err
  )

task "compress", 'Uglify JS', (params)->
  util.print "Compressing...\n"
  code = (fs.readFileSync "automan.js").toString()
  code = uglify.gen_code uglify.ast_squeeze uglify.ast_mangle parser.parse code
  fs.writeFileSync "automan.min.js", code

  util.print "Complete!\n"

task 'build', 'build docs and compress assets', ->
  invoke 'doc'
  invoke 'compress'

task 'test', 'Run mocha specs', ->
  invoke 'build'
  exec "open tests.html"
