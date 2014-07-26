_ = require 'underscore'

featureToggle = (feature, truths) ->
  if !truths or truths.length is 0
    return process.env["FT_#{feature}".toUpperCase()] is 'true' or false

  if(_.any truths, (truth) -> typeof truth isnt 'function')
    throw new Error('expected a function')

  _.every truths, (truth) -> truth process.env["FT_#{feature}".toUpperCase()]

featureToggle.getToggles = ->
  toggles = {}

  _.each process.env, (value, key) ->
    prefix = key.toString().slice(0, 2).toUpperCase()
    suffix = key.toString().slice(3).toLowerCase()
    if prefix is 'FT'
      toggles[suffix] = value is 'true'

  return toggles

module.exports = featureToggle
