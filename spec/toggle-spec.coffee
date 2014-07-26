toggle = require '../src/toggle'
_ = require 'underscore'

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

  describe 'toggle with truth params', ->

    it 'throws an error if truth params are not functions', ->
      truth = 'not a function'

      try
        toggle('feature', truth)
        # should not get here
        true.should.equal false
      catch e
        e.message.should.equal 'expected a function'
      
    it 'returns true if all truth functions return true when compared with the value of the env', ->
      @stub process, 'env', FT_HEADER_NAV: 'homeyer,marydavis'

      truthA = (val) -> _.contains val.split(','), 'homeyer'
      truthB = (val) -> _.contains val.split(','), 'marydavis'

      actual = toggle 'header_nav', [truthA, truthB]
      actual.should.be.true


    it 'returns false if any truth param returns false', ->
      @stub process, 'env', FT_HEADER_NAV: 'homeyer'

      truthA = (val) -> _.contains val.split(','), 'homeyer'
      truthB = (val) -> _.contains val.split(','), 'marydavis'

      actual = toggle 'header_nav', [truthA, truthB]
      actual.should.be.false 

  describe 'getToggles', ->
    beforeEach ->
      @stub process, 'env',
        FT_FEATURE: "false"
        FT_PRICING: "true"

    it 'lists all toggles', ->
      actual = toggle.getToggles()
      actual.should.eql {feature: false, pricing: true}