namespace "Models", (Models) ->
  class Models.Room extends Backbone.Model
    initialize: ->
      @_items = new Collections.Items

    items: ->
      @_items
