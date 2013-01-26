#= require models/base

namespace "Models", (Models) ->
  Models.Editor = (I={}) ->
    {room} = I

    tools = [
      Models.Tool.tools.Move
      Models.Tool.tools.Interact
    ]

    toolbar = Models.Toolbar
      tools: tools

    passToCurrentTool = (name) ->
      return (event) ->
        target = $(event.currentTarget)
        instance = ko.dataFor(this)

        self.currentTool()[name]
          editor: self
          element: target
          event: event
          instance: instance

    self = Models.Base(I).extend
      editText: (instance) ->
        self.textItem(instance)

      save: ->
        console.log room.toJSON()

      toolbar: toolbar

      currentTool: ->
        self.toolbar.activeTool()

      toolTap: passToCurrentTool("tap")
      toolStart: passToCurrentTool("start")
      toolMove: passToCurrentTool("move")

      toolEnd: (event) ->
        target = $(event.currentTarget)
        instance = ko.dataFor(this)

        self.currentTool().end
          editor: self
          element: target
          event: event
          instance: instance

        # TODO: Generalize drop targets
        # Check for dumper
        trashOffset = self.element.find(".trash").offset()
        if event.pageX > trashOffset.left and event.pageY > trashOffset.top
          room.removeInstance(item)

    self.observe "textItem"

    return self
