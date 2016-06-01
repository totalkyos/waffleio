toggle = require '../src/toggle'
_ = require 'lodash'

describe 'toggle', ->
  describe 'with feature undefined', ->
    it 'should return false', ->
      toggle('feature').should.be.false

  describe 'with feature off', ->
    beforeEach ->
      @sinon.stub process, 'env', FT_FEATURE: "false"

    it 'should return false', ->
      toggle('feature').should.be.false

  describe 'with feature on', ->
    beforeEach ->
      @sinon.stub process, 'env', FT_FEATURE: "true"

    it 'should return true', ->
      toggle('feature').should.be.true

  describe 'with truth params', ->
    describe 'passed as an array', ->
      it 'throws an error if truth params are not functions', ->
        @sinon.stub process, 'env', FT_FEATURE: 'thing'
        truth = 'not a function'

        try
          toggle 'feature', [truth]
          # should not get here
          true.should.equal false
        catch e
          e.message.should.equal 'expected a function'

      it 'returns true if all truth functions return true when compared with the value of the env', ->
        @sinon.stub process, 'env', FT_HEADER_NAV: 'homeyer,marydavis'

        truthA = (val) -> _.includes val.split(','), 'homeyer'
        truthB = (val) -> _.includes val.split(','), 'marydavis'

        actual = toggle 'header_nav', [truthA, truthB]
        actual.should.be.true

      it 'returns false if any truth param returns false', ->
        @sinon.stub process, 'env', FT_HEADER_NAV: 'homeyer'

        truthA = (val) -> _.includes val.split(','), 'homeyer'
        truthB = (val) -> _.includes val.split(','), 'marydavis'

        actual = toggle 'header_nav', [truthA, truthB]
        actual.should.be.false

      it 'doesnt check truth params if env not set', ->
        @sinon.stub process, 'env', {}
        truth = @sinon.stub()
        toggle 'header_nav', [truth]
        truth.callCount.should.eql 0

      it 'is true if toggle value is "true"', ->
        @sinon.stub process, 'env', FT_HEADER_NAV: 'true'

        truthA = (val) -> _.includes val.split(','), 'homeyer'
        truthB = (val) -> _.includes val.split(','), 'marydavis'

        actual = toggle 'header_nav', [truthA, truthB]
        actual.should.be.true

      it 'is false if toggle value is "false"', ->
        @sinon.stub process, 'env', FT_HEADER_NAV: 'false'

        truthA = (val) -> _.includes val.split(','), 'homeyer'
        truthB = (val) -> _.includes val.split(','), 'marydavis'

        actual = toggle 'header_nav', [truthA, truthB]
        actual.should.be.false

    describe 'passes as separate arguments', ->
      it 'throws an error if truth params are not functions', ->
        @sinon.stub process, 'env', FT_FEATURE: 'thing'
        truth = 'not a function'

        try
          toggle 'feature', truth
          # should not get here
          true.should.equal false
        catch e
          e.message.should.equal 'expected a function'

      it 'returns true if all truth functions return true when compared with the value of the env', ->
        @sinon.stub process, 'env', FT_HEADER_NAV: 'homeyer,marydavis'

        truthA = (val) -> _.includes val.split(','), 'homeyer'
        truthB = (val) -> _.includes val.split(','), 'marydavis'

        actual = toggle 'header_nav', truthA, truthB
        actual.should.be.true

      it 'returns false if any truth param returns false', ->
        @sinon.stub process, 'env', FT_HEADER_NAV: 'homeyer'

        truthA = (val) -> _.includes val.split(','), 'homeyer'
        truthB = (val) -> _.includes val.split(','), 'marydavis'

        actual = toggle 'header_nav', [truthA, truthB]
        actual.should.be.false

      it 'doesnt check truth params if env not set', ->
        @sinon.stub process, 'env', {}
        truth = @sinon.stub()
        toggle 'header_nav', truth
        truth.callCount.should.eql 0

      it 'is true if toggle value is "true"', ->
        @sinon.stub process, 'env', FT_HEADER_NAV: 'true'

        truthA = (val) -> _.includes val.split(','), 'homeyer'
        truthB = (val) -> _.includes val.split(','), 'marydavis'

        actual = toggle 'header_nav', truthA, truthB
        actual.should.be.true

      it 'is false if toggle value is "false"', ->
        @sinon.stub process, 'env', FT_HEADER_NAV: 'false'

        truthA = (val) -> _.includes val.split(','), 'homeyer'
        truthB = (val) -> _.includes val.split(','), 'marydavis'

        actual = toggle 'header_nav', truthA, truthB
        actual.should.be.false

  describe 'getToggles', ->
    beforeEach ->
      @sinon.stub process, 'env',
        FT_FEATURE: "false"
        FT_PRICING: "true"

    it 'lists all toggles', ->
      actual = toggle.getToggles()
      actual.should.eql {feature: false, pricing: true}
