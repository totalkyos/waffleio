_ = require 'lodash'

module.exports =
  everyValueInList: (list...) ->
    list = _.flatten list
    (toggleValue) ->
      return false if _.isEmpty list
      _.every list, (item) -> item in toggleValue.split ','

  anyValueInList: (list...) ->
    list = _.flatten list
    (toggleValue) ->
      return false if _.isEmpty list
      _.some list, (item) -> item in toggleValue.split ','
