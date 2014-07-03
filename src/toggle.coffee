_ = require 'underscore'

featureToggle = (feature) ->
  process.env["FT_#{feature}".toUpperCase()] is 'true' or false

featureToggle.getToggles = ->
  toggles = {}

  _.each process.env, (value, key) ->
    prefix = key.toString().slice(0, 2).toUpperCase()
    suffix = key.toString().slice(3).toLowerCase()
    if prefix is 'FT'
      toggles[suffix] = value is 'true'

  return toggles

module.exports = featureToggle
