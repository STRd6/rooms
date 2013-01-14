#= require models/instance

namespace "Collections", (Collections) ->
  class Collections.Instances extends Backbone.Collection
    model: Models.Instance
