namespace "Views", (Views) ->
  Views.Editor = (I) ->
    {items, room} = I

    element = $(JST['editor']())
    model = Models.Editor
      room: room
    # TOOD: Don't have model know explicitly of element
    model.element = element

    ko.applyBindings model, element.get(0)

    Views.Room
      model: room
    .appendTo(element)

    Views.Toolbar
      model: model.toolbar
    .appendTo(element)

    Views.ItemPalette
      model:
        items: items
    .appendTo(element)

    element.append JST["trash"]()

    element.appendTo("body")

    # Bind some events
    selector = ".room .item"
    element.on "movestart", selector, model.toolStart
    element.on "move", selector, model.toolMove
    element.on "moveend", selector, model.toolEnd
    element.on "touchstart mousedown", selector, model.toolTap

    return element
