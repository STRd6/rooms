namespace "Models", (Models) ->
  class Models.Base extends Backbone.Model
    @new = (args...) ->
      new @ args...
