
require("should")
assert = require("assert")

# dump test to have an empty test for setup
describe "Array", () ->
  describe "indexOf", () ->
    it "should return -1 when the value is not present", () ->
      assert.equal(-1, [1,2,3].indexOf(5))


