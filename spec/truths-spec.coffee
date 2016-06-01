toggle = require '../src'

describe 'toggle.truths', ->
  beforeEach ->
    process.env.FT_TEST = '1234,username,5678,repo'

  describe '#everyValueInList', ->
    describe 'when items are separate arguments', ->
      it 'returns true if all items exist in the toggle value', ->
        toggle('test', toggle.truths.everyValueInList('username', '5678')).should.be.true

      it 'returns true if single item exists in the toggle value of one item', ->
        toggle('test', toggle.truths.everyValueInList('username')).should.be.true

      it 'returns false if more items passed than toggle values', ->
        toggle('test', toggle.truths.everyValueInList('username', '1234', '5678', 'repo', 'foo')).should.be.false

      it 'returns false if some items do not exist in the toggle value', ->
        toggle('test', toggle.truths.everyValueInList('1234', 'foo', '5678')).should.be.false

      it 'returns false if no items are specified', ->
        toggle('test', toggle.truths.everyValueInList()).should.be.false

      it 'returns false if a single undefined item is specified', ->
        toggle('test', toggle.truths.everyValueInList(undefined)).should.be.false

    describe 'when items is an array', ->
      it 'returns true if all items exist in the toggle value', ->
        toggle('test', toggle.truths.everyValueInList(['username', '5678'])).should.be.true

      it 'returns true if single item exists in the toggle value of one item', ->
        toggle('test', toggle.truths.everyValueInList(['username'])).should.be.true

      it 'returns false if more items passed than toggle values', ->
        toggle('test', toggle.truths.everyValueInList(['username', '1234', '5678', 'repo', 'foo'])).should.be.false

      it 'returns false if some items do not exist in the toggle value', ->
        toggle('test', toggle.truths.everyValueInList(['1234', 'foo', '5678'])).should.be.false

      it 'returns false if empty array specified', ->
        toggle('test', toggle.truths.everyValueInList([])).should.be.false

      it 'returns false if array with one undefined item specified', ->
        toggle('test', toggle.truths.everyValueInList([undefined])).should.be.false

  describe '#anyValueInList', ->
    describe 'when items are separate arguments', ->
      it 'returns true if one item exists in toggle value', ->
        toggle('test', toggle.truths.anyValueInList('repo')).should.be.true

      it 'returns true if multiple items exists in toggle value', ->
        toggle('test', toggle.truths.anyValueInList('1234', 'username')).should.be.true

      it 'returns true if all items exists in toggle value', ->
        toggle('test', toggle.truths.anyValueInList('1234', 'repo', 'username', '5678')).should.be.true

      it 'ignores undefined items', ->
        toggle('test', toggle.truths.anyValueInList('repo', undefined, '5678')).should.be.true

      it 'returns false if no item exists in toggle value', ->
        toggle('test', toggle.truths.anyValueInList('foo', 'bar')).should.be.false

      it 'returns false if no items are specified', ->
        toggle('test', toggle.truths.anyValueInList()).should.be.false

      it 'returns false if a single undefined item is specified', ->
        toggle('test', toggle.truths.anyValueInList(undefined)).should.be.false

    describe 'when items is an array', ->
      it 'returns true if one item exists in toggle value', ->
        toggle('test', toggle.truths.anyValueInList(['repo'])).should.be.true

      it 'returns true if multiple items exists in toggle value', ->
        toggle('test', toggle.truths.anyValueInList(['1234', 'username'])).should.be.true

      it 'returns true if all items exists in toggle value', ->
        toggle('test', toggle.truths.anyValueInList(['1234', 'repo', 'username', '5678'])).should.be.true

      it 'ignores undefined items', ->
        toggle('test', toggle.truths.anyValueInList(['repo', undefined, '5678'])).should.be.true

      it 'returns false if no item exists in toggle value', ->
        toggle('test', toggle.truths.anyValueInList(['foo', 'bar'])).should.be.false

      it 'returns false if empty array specified', ->
        toggle('test', toggle.truths.anyValueInList([])).should.be.false

      it 'returns false if array with one undefined item specified', ->
        toggle('test', toggle.truths.anyValueInList([undefined])).should.be.false
