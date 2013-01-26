#= require models/base

namespace "Models", (Models) ->
  Models.Editor = (I={}) ->

    dataStore = Local.new "LOCODAT"
    roomData = dataStore.get("rooms") or []

    rooms = ko.observableArray roomData.map Models.Room
    unless rooms().length
      rooms.push Models.Room()

    room = ko.observable rooms().first()

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

      editLink: (instance) ->
        self.linkInstance(instance)

      save: ->
        roomData = ko.toJS(rooms)
        dataStore.set "rooms", roomData
        console.log roomData

      newRoom: ->
        newRoom = Models.Room()

        rooms.push(newRoom)
        self.room(newRoom)

      done: ->
        self.textInstance(null)
        self.linkInstance(null)

      toolbar: toolbar
      room: room
      rooms: rooms

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
          room().removeInstance(instance)

    self.observe "textInstance", "linkInstance"

    return self
