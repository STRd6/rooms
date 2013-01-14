#= require models/item

namespace "Collections", (Collections) ->
  class Collections.Items extends Backbone.Collection
    model: Models.Item
