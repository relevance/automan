global.jQuery  = require("jquery")

should  = require('chai').should()
Automan = require('../automan.js.coffee').Automan

describe "Automan", ->

  describe ".on()", ->
    clicked = false

    beforeEach ->
      $el = jQuery('<div>').attr('id', 'myElement')
      $el.click ->
        clicked = true

      jQuery('body').append($el)

    it "should click on an element", ->
      clicked.should.equal(false)
      Automan.on('#myElement')
      clicked.should.equal(true)
