namespace "Models", (Models) ->
  Models.Item = (I) ->

    src: =>
      {spriteId} = I
      i = spriteId % 4

      return "http://#{i}.pixiecdn.com/sprites/#{spriteId}/original.png"
