namespace "Views", (Views) ->
  Views.ItemPalette = (I) ->

    element = $(JST['item_palette']())
    ko.applyBindings I.model, element.get(0)

    return element
