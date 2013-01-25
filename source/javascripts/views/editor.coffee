namespace "Views", (Views) ->
  Views.Editor = (I) ->
    {items, room} = I

    element = $ "<div>",
      class: "editor"

    Views.Room
      model: room
    .appendTo(element)

    tools = [
      Models.Tool.tools.Move
      Models.Tool.tools.Interact
    ]

    toolbar = Models.Toolbar
      tools: tools

    Views.Toolbar
      model: toolbar
    .appendTo(element)

    Views.ItemPalette
      model:
        items: items
    .appendTo(element)

    element.append JST["trash"]()

    element.appendTo("body")

    passToCurrentTool = (name) ->
      return (event) ->
        target = $(event.currentTarget)
        item = ko.dataFor(this)

        self.currentTool()[name]
          element: target
          event: event
          item: item

    self = Core(I).extend
      currentTool: ->
        toolbar.activeTool()

      toolTap: passToCurrentTool("tap")
      toolStart: passToCurrentTool("start")
      toolMove: passToCurrentTool("move")

      toolEnd: (event) ->
        target = $(event.currentTarget)
        item = ko.dataFor(this)

        self.currentTool().end
          element: target
          event: event
          item: item

        # TODO: Generalize drop targets
        # Check for dumper
        trashOffset = element.find(".trash").offset()
        if event.pageX > trashOffset.left and event.pageY > trashOffset.top
          room.removeInstance(item)

    # Bind some events
    selector = ".room .item"
    element.on "movestart", selector, self.toolStart
    element.on "move", selector, self.toolMove
    element.on "moveend", selector, self.toolEnd
    element.on "touchstart mousedown", selector, self.toolTap

    return self
