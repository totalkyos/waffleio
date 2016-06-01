sinon = require 'sinon'
chai = require 'chai'
chai.use require('chai-things')
global.should = chai.should()

before -> @sinon = sinon.sandbox.create()
afterEach -> @sinon.restore()
