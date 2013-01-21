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

  getPos = (event) ->
    e = event.originalEvent.touches?[0] || event

    y: e.pageY
    x: e.pageX

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

  # Dragging
  $(".room").on "mousedown touchstart", ".item", (e) ->
    e.preventDefault()

    p = getPos(e)

    roomItem = $(e.currentTarget)

    offset = {
      top: p.y - parseInt(roomItem.css('top'), 10)
      left: p.x - parseInt(roomItem.css('left'), 10)
    }

  $(".itemPalette").on "mousedown touchstart", ".item", (e) ->
    e.preventDefault()

    activeItem = $(e.currentTarget)
    initDraggy(activeItem.parent(), e)

    # offset = activeItem.offset()

  $(document).on "mousemove touchmove", (e) ->
    p = getPos(e)

    if activeItem
      draggy.css
        top: p.y
        left: p.x

    if roomItem
      x = p.x - offset.left
      y = p.y - offset.top
      roomItem.data("model").set
        x: x
        y: y

      roomItem.css
        top: y
        left: x

  $(document.body).on "mouseup touchend", (e) ->
    p = getPos(e)

    if activeItem
      {left, top} = $(".room").offset()
      x = p.x - left
      y = p.y - top

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
      if p.x > trashOffset.left and p.y > trashOffset.top
        roomItem.data("model").destroy()

    activeItem = null
    roomItem = null
    draggy = null
