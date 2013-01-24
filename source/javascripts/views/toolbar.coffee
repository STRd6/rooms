namespace "Views", (Views) ->
  Views.Toolbar = (I) ->

    element = $(JST['toolbar']())
    ko.applyBindings I.model, element.get(0)

    return element
