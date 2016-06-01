toggle = require '../src'

describe 'index', ->
  it 'exports toggles and truths', ->
    should.exist toggle
    toggle.should.be.a 'function'

    should.exist toggle.truths
    toggle.truths.should.be.an 'object'
    val.should.be.a 'function' for key, val of toggle.truths
