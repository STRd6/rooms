#= require models/base

namespace "Models", (Models) ->
  Models.Instance = (I={}) ->
    Object.reverseMerge I,
      x: 0
      y: 0
      width: 32
      height: 32
      imageId: 1

    self = Models.Base(I).extend
      imageUrl: ->
        I.imageUrl

      interact: ->
        console.log "Hella interactive"

    self.observe "x", "y", "width", "height"

    return self
