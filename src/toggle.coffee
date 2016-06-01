_ = require 'lodash'

featureToggle = (feature, truths...) ->
  value = process.env["FT_#{feature}".toUpperCase()]

  return false unless value
  return JSON.parse(value) if value in ['true', 'false']

  truths = _.flatten truths
  if !truths or truths.length is 0
    return process.env["FT_#{feature}".toUpperCase()] is 'true' or false

  if(_.some truths, (truth) -> typeof truth isnt 'function')
    throw new Error('expected a function')

  _.every truths, (truth) -> truth process.env["FT_#{feature}".toUpperCase()]

featureToggle.getToggles = ->
  toggles = {}

  _.forEach process.env, (value, key) ->
    prefix = key.toString().slice(0, 2).toUpperCase()
    suffix = key.toString().slice(3).toLowerCase()
    if prefix is 'FT'
      toggles[suffix] = value is 'true'
    return

  return toggles

module.exports = featureToggle
