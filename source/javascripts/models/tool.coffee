#= require models/base

namespace "Models", (Models) ->
  class Models.Tool extends Models.Base
    defaults:
      name: "Move"
      icon: ""
      start: ->
      move: ->
      end: ->
      tap: ->

    initialize: ->
      [
        "start"
        "move"
        "end"
        "tap"
      ].each (action) =>
        @[action] = (args...) ->
          @get(action)(args...)

    src: ->
      @get('icon')

    name: ->
      @get('name')

  Models.Tool.tools = {
    Interact:
      tap: ({item}) ->
        item.data("model").interact()

    Move:
      start: ({event, item}) ->
        offset = item.offset()

        x = event.pageX - offset.left
        y = event.pageY - offset.top

        item.data "initialOffset",
          x: x
          y: y

      move: ({event, item}) ->
        offset = item.parent().offset()
        initialOffset = item.data("initialOffset") or Point.ZERO

        x = event.pageX - offset.left - initialOffset.x
        y = event.pageY - offset.top - initialOffset.y

        item.data("model").set
          x: x
          y: y

        item.css
          top: y
          left: x
  }

  for name, data of Models.Tool.tools
    Models.Tool.tools[name] = new Models.Tool data
