#= require models/base

namespace "Models", (Models) ->
  Models.Tool = (I) ->
    Object.reverseMerge I,
      name: "Move"
      icon: ""
      start: ->
      move: ->
      end: ->
      tap: ->

    self = Models.Base(I).extend
      src: ->
        I.icon

      name: ->
        I.name

    [
      "start"
      "move"
      "end"
      "tap"
    ].each (action) ->
      self[action] = (args...) ->
        I[action](args...)

    return self

  Models.Tool.tools = {
    Interact:
      tap: ({item}) ->
        item.data("model").interact()

    Text:
      tap: ({item, editor}) ->
        instance = item.data("model")

        editor.editText(instance)

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
    Models.Tool.tools[name] = Models.Tool data
