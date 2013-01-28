namespace "Views", (Views) ->
  Views.ItemPalette = (I) ->

    items = ko.observable([])

    $.get "http://pixieengine.com/DanielXMoore/sprites.json", (data) ->
      items data.models.map ({id}) ->
        Models.Item
          spriteId: id

    element = $(JST['item_palette']())
    ko.applyBindings {
      items: items
    }, element.get(0)

    return element
