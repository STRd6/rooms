namespace "Views", (Views) ->
  class Views.Editor extends Backbone.View
    className: "editor"

    initialize: ->
      {items, room} = @options

      new Views.ItemPalette
        collection: items
      .render().$el.appendTo(@$el)

      @$el.append JST["trash"]()

      @render()

      @$el.appendTo("body")

    render: ->
      # TODO: Add toolbar
      # TODO: Add dragging code

      return this
