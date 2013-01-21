$ ->
  images = [
    13967
    17138
    8051
    8764
    9032
  ]

  items = new Collections.Items
  for id in images
    items.add
      spriteId: id

  room = new Models.Room

  new Views.Editor
    items: items
    room: room

  new Views.Room
    model: room
  .render()

  # TODO: Undo / Redo
  # TODO: Add select, group, delete tools
  # TODO: Make all this dragging a "move" tool
  # TODO: Localize events from document to editor
  activeItem = null
  roomItem = null
  draggy = null
  offset = {left: 0, top: 0}
  start = {left: 0, top: 0}

  initDraggy = (element, e) ->
    p = e.originalEvent.touches[0] || e

    draggy = element
      .clone()
      .appendTo("body").css
        opacity: 0.5
        position: "absolute"
        top: p.pageY
        left: p.pageX
        zIndex: 9000

  # Dragging
  $(".room").on "mousedown touchstart", ".item", (e) ->
    e.preventDefault()

    p = e.originalEvent.touches[0] || e

    roomItem = $(e.currentTarget)

    offset = {
      top: p.pageY - parseInt(roomItem.css('top'), 10)
      left: p.pageX - parseInt(roomItem.css('left'), 10)
    }

  $(".itemPalette").on "mousedown touchstart", ".item", (e) ->
    e.preventDefault()

    activeItem = $(e.currentTarget)
    initDraggy(activeItem.parent(), e)

    # offset = activeItem.offset()

  $(document).on "mousemove touchmove", (e) ->
    p = e.originalEvent.touches[0] || e

    if activeItem
      draggy.css
        top: p.pageY
        left: p.pageX

    if roomItem
      x = p.pageX - offset.left
      y = p.pageY - offset.top
      roomItem.data("model").set
        x: x
        y: y

      roomItem.css
        top: y
        left: x

  $(document.body).on "mouseup touchend", (e) ->
    p = e.originalEvent.touches[0] || e

    if activeItem
      {left, top} = $(".room").offset()
      x = p.pageX - left
      y = p.pageY - top

      imageUrl = if src = activeItem.attr('src')
        "url(#{src})"
      else
        activeItem.css("backgroundImage")

      room.addInstance
        x: x
        y: y
        width: activeItem.width()
        height: activeItem.height()
        imageUrl: imageUrl

      draggy.remove()

    if roomItem
      trashOffset = $(".trash").offset()
      if p.pageX > trashOffset.left and p.pageY > trashOffset.top
        roomItem.data("model").destroy()

    activeItem = null
    roomItem = null
    draggy = null
