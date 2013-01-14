$ ->
  Room =
    addDoor: (data) ->
      $(".room").append $("<a>", data)

    addItem: (data) ->
      {x, y, width, height, imageUrl} = data
      $(".room").append $("<div>",
        class: "item"
        css:
          backgroundImage: imageUrl
          left: x
          top: y
        width: width
        height: height
      )

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

  data = [{
    type: "door"
    href: "http://www.google.com"
    width: 32
    height: 32
    class: "item"
    css:
      backgroundImage: "url(/images/middleman.png)"
      top: "0px"
      left: "0px"
  }]

  for item in data
    Room.addDoor(item)

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
      roomItem.css
        top: e.pageY - offset.top
        left: e.pageX - offset.left

  $(document.body).on "mouseup", (e) ->
    if activeItem
      {left, top} = $(".room").offset()
      x = e.pageX - left
      y = e.pageY - top

      imageUrl = if src = activeItem.attr('src')
        "url(#{src})"
      else
        activeItem.css("backgroundImage")

      Room.addItem
        x: x
        y: y
        width: activeItem.width()
        height: activeItem.height()
        imageUrl: imageUrl

      draggy.remove()

    activeItem = null
    roomItem = null
    draggy = null
