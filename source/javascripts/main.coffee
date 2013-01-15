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

  # TODO: Manage appending to correct element
  new Views.ItemPalette
    collection: items
  .render()

  room = new Models.Room

  new Views.Room
    model: room
  .render()

  # TODO: Persist Data
  # TODO: Toggle play and edit modes
  # TODO: Undo / Redo
  # TODO: Add select, group, delete tools
  # TODO: Make all this dragging a "move" tool
  activeItem = null
  roomItem = null
  draggy = null
  offset = {left: 0, top: 0}
  start = {left: 0, top: 0}

  initDraggy = (element, e) ->
    draggy = element
      .clone()
      .appendTo("body").css
        opacity: 0.5
        position: "absolute"
        top: e.pageY
        left: e.pageX
        zIndex: 9000

  # Dragging
  $(".room").on "mousedown", ".item", (e) ->
    e.preventDefault()

    roomItem = $(e.currentTarget)

    offset = {
      top: e.pageY - parseInt(roomItem.css('top'), 10)
      left: e.pageX - parseInt(roomItem.css('left'), 10)
    }

  $(".itemPalette").on "mousedown", ".item", (e) ->
    e.preventDefault()

    activeItem = $(e.currentTarget)
    initDraggy(activeItem.parent(), e)

    # offset = activeItem.offset()

  $(document).on "mousemove", (e) ->
    if activeItem
      draggy.css
        top: e.pageY
        left: e.pageX

    if roomItem
      x = e.pageX - offset.left
      y = e.pageY - offset.top
      roomItem.data("model").set
        x: x
        y: y

      roomItem.css
        top: y
        left: x

  $(document.body).on "mouseup", (e) ->
    if activeItem
      {left, top} = $(".room").offset()
      x = e.pageX - left
      y = e.pageY - top

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

    activeItem = null
    roomItem = null
    draggy = null
