namespace "Views", (Views) ->
  Views.Room = (I) ->

    element = $(JST['room']())
    ko.applyBindings I.model, element.get(0)

    return element
