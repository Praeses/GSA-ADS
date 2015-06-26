require("../../src/views/script/chart_lib.coffee")
require("should")
assert = require("assert")

# dump test to have an empty test for setup
describe "ChartLib", () ->

  describe "Object", () ->
    it "should exist", () ->
      App.ChartLib.should.be.ok


  describe "capitalize", () ->

    it "should capitalize a string", () ->
      str = App.ChartLib.capitalize("string")
      str.should.be.eql("String")

    it "should do noting to a capitalized string", () ->
      str = App.ChartLib.capitalize("String")
      str.should.be.eql("String")

  describe "capitalize", () ->


