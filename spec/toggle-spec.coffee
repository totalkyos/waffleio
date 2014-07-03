toggle = require '../src/toggle'

describe 'toggle', ->
  describe 'with feature undefined', ->
    it 'should return false', ->
      toggle('feature').should.be.false

  describe 'with feature off', ->
    beforeEach ->
      @stub process, 'env', FT_FEATURE: "false"

    it 'should return false', ->
      toggle('feature').should.be.false

  describe 'with feature on', ->
    beforeEach ->
      @stub process, 'env', FT_FEATURE: "true"

    it 'should return true', ->
      toggle('feature').should.be.true

  describe 'getToggles', ->
    beforeEach ->
      @stub process, 'env',
        FT_FEATURE: "false"
        FT_PRICING: "true"

    it 'lists all toggles', ->
      actual = toggle.getToggles()
      actual.should.eql {feature: false, pricing: true}
