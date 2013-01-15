#= require models/instance

namespace "Collections", (Collections) ->
  class Collections.Instances extends Backbone.Collection
    localStorage: new Backbone.LocalStorage("Instances")
    model: Models.Instance
