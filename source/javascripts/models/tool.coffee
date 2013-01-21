namespace "Models", (Models) ->
  class Models.Tool extends Models.Base
    initialize: ->

  Models.Tool.tools = [
    "interact"
    "move"
    "edit"
  ].map (name) ->
    Models.Tool.new
      name: name
