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
        if text = self.text()
          alert text
        else if link = self.link()
          # GOTO Link
          console.log "GOTO: #{link}"

      toJSON: ->
        x: self.x()
        y: self.y()
        width: self.width()
        height: self.height()
        imageUrl: self.imageUrl()
        text: self.text()
        link: self.link()

    self.observe(
      "x"
      "y"
      "width"
      "height"
      "link"
      "text"
    )

    return self
