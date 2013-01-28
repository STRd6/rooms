namespace "Views", (Views) ->
  Views.Editor = (I) ->
    {Instance} = Models

    element = $(JST['editor']())
    editor = Models.Editor()

    # TOOD: Don't have model know explicitly of element
    editor.element = element

    ko.applyBindings editor, element.get(0)

    Views.Room
      model: editor.room
    .appendTo(element)

    Views.Toolbar
      model: editor.toolbar
    .appendTo(element)

    Views.ItemPalette().appendTo(element)

    element.append JST["trash"]()

    element.appendTo("body")

    # Bind some events
    selector = ".room .item"
    element.on "movestart", selector, editor.toolStart
    element.on "move", selector, editor.toolMove
    element.on "moveend", selector, editor.toolEnd
    element.on "touchstart mousedown", selector, editor.toolTap

    # Crazy Drag and Drop from Item Palette
    activeItem = null
    draggy = null

    getPos = (event) ->
      y: event.pageY
      x: event.pageX

    initDraggy = (element, e) ->
      p = getPos(e)

      draggy = element
        .clone()
        .appendTo("body").css
          opacity: 0.5
          position: "absolute"
          top: p.y
          left: p.x
          zIndex: 9000

    $(".itemPalette").on "movestart", ".item", (e) ->
      activeItem = $(e.currentTarget)
      initDraggy(activeItem.parent(), e)

    element.on "move", (e) ->
      p = getPos(e)

      if activeItem
        draggy.css
          top: p.y
          left: p.x

    element.on "moveend", (e) ->
      p = getPos(e)

      if activeItem
        {left, top} = $(".room").offset()
        x = p.x - left
        y = p.y - top

        imageUrl = if src = activeItem.attr('src')
          "url(#{src})"
        else
          activeItem.css("backgroundImage")

        editor.room().addInstance Instance
          x: x
          y: y
          width: activeItem.width()
          height: activeItem.height()
          imageUrl: imageUrl

        draggy.remove()

      activeItem = null
      draggy = null
    # End Crazy Drag and Drop

    getRoomByUuid = (uuid) ->
      editor.rooms().filter (room) ->
        room.uuid() is uuid
      .first()

    # Routes Madness
    Sammy(->
      @get "#:uuid", ->
        {uuid} = @params

        if room = getRoomByUuid(uuid)
          editor.room(room)

      @get '', ->
        location.hash = editor.room().uuid()

    ).run()

    return element
