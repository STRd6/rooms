$ ->
  items = [
    13967
    17138
    8051
    8764
    9032
  ].map (id) ->
    Models.Item
      spriteId: id

  # TODO: Storage
  instances = _.uniq((localStorage.Instances || "").split(",")).map (id) ->
    Models.Instance JSON.parse(localStorage["Instances-#{id}"])
  room = Models.Room
    instances: instances

  roomElement = $(JST['room']())
  ko.applyBindings room, roomElement.get(0)
  $('body').append roomElement

  # new Views.Editor
  #   items: items
  #   room: room

  # TODO: Undo / Redo
  # TODO: Add select, group, delete tools
  # TODO: Make all this dragging a "move" tool
  # TODO: Localize events from document to editor
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

  $(document).on "move", (e) ->
    p = getPos(e)

    if activeItem
      draggy.css
        top: p.y
        left: p.x

  $(document.body).on "moveend", (e) ->
    p = getPos(e)

    if activeItem
      console.log $(".room").offset(), p
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

    activeItem = null
    draggy = null
