namespace "Views", (Views) ->
  class Views.ItemPalette extends Backbone.View
    className: "itemPalette"

    render: ->
      @$el.empty()

      @collection.each (item) =>
        @$el.append JST["palette_item"](src: item.src())

      $("body").append @$el

      return this
