namespace "Models", (Models) ->
  class Models.Instance extends Backbone.Model
    defaults:
      x: 0
      y: 0
      width: 32
      height: 32
      imageId: 1

    initialize: (options) ->
      @item = options.item

    imageUrl: =>
      @get "imageUrl"
