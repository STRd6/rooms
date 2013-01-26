#= require models/base

namespace "Models", (Models) ->
  Models.Editor = (I={}) ->

    dataStore = Local.new "LOCODAT"
    roomData = dataStore.get("rooms") or {}
    roomIds = Object.keys roomData

    room = Models.Room roomData[roomIds.first()]

    debugger

    tools = [
      "Move"
      "Interact"
      "Text"
      "Link"
    ].map (name) ->
      Models.Tool.tools[name]

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
        self.textInstance(instance)

      save: ->
        roomData[room.uuid()] = room.toJSON()
        dataStore.set "rooms", roomData

      done: ->
        self.textInstance(null)

      toolbar: toolbar
      room: room

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
          room.removeInstance(instance)

    self.observe "textInstance"

    return self
