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
    'node_modules/docco/bin/docco automan.js.coffee'
  ].join(' && '), (err) ->
    throw err if err
  )


task 'convert', 'convert to JS', ->
  code = (fs.readFileSync "automan.js.coffee").toString()
  jsCode = CoffeeScript.compile code.toString()
  util.print("Converting to JS in automan.js\n")
  fs.writeFileSync "automan.js", jsCode

task "compress", 'Uglify JS', (params)->
  util.print "Compressing...\n"
  code = (fs.readFileSync "automan.js").toString()
  code = uglify.gen_code uglify.ast_squeeze uglify.ast_mangle parser.parse code
  fs.writeFileSync "automan.min.js", code

  util.print "Complete!\n"

task 'build', 'convert and compress assets', ->
  invoke 'doc'
  invoke 'convert'
  invoke 'compress'

task 'test', 'Run mocha specs', ->
  files = [ 'automan_spec.js.coffee' ]
  for file in files
    exec "node_modules/mocha/bin/mocha --reporter spec --compilers coffee:coffee-script test/#{file}",
      (err, stdout, stderr) ->
        print stdout if stdout?
        print stderr if stderr?
