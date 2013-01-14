namespace "Models", (Models) ->
  class Models.Item extends Backbone.Model
    src: =>
      {spriteId} = @attributes
      i = spriteId % 4

      return "http://#{i}.pixiecdn.com/sprites/#{spriteId}/original.png"
