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
        item.interact()

    Text:
      tap: ({item, editor}) ->
        editor.editText(item)

    Move:
      start: ({event, element}) ->
        offset = element.offset()

        x = event.pageX - offset.left
        y = event.pageY - offset.top

        element.data "initialOffset",
          x: x
          y: y

      move: ({event, element, item}) ->
        offset = element.parent().offset()
        initialOffset = element.data("initialOffset") or Point.ZERO

        x = event.pageX - offset.left - initialOffset.x
        y = event.pageY - offset.top - initialOffset.y

        item.x(x)
        item.y(y)
  }

  for name, data of Models.Tool.tools
    Models.Tool.tools[name] = Models.Tool data
