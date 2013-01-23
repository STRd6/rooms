#= require models/tool

namespace "Collections", (Collections) ->
  class Collections.Tools extends Backbone.Collection
    model: Models.Tool
