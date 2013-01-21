namespace "Views", (Views) ->
  class Views.Editor extends Backbone.View
    className: "editor"

    events:
      "move .room .item": "moveItem"
      "moveend .room .item": "releaseItem"

    initialize: ->
      {items, room} = @options

      new Views.ItemPalette
        collection: items
      .render().$el.appendTo(@$el)

      new Views.Room
        model: room
      .render().$el.appendTo(@$el)

      @$el.append JST["trash"]()

      @render()

      @$el.appendTo("body")

    moveItem: (event) ->
      roomItem = $(event.currentTarget)

      offset = roomItem.parent().offset()

      #TODO Initail touch Offset
      x = event.pageX - offset.left
      y = event.pageY - offset.top

      roomItem.data("model").set
        x: x
        y: y

      roomItem.css
        top: y
        left: x

    releaseItem: (event) ->
      item = $(event.currentTarget)

      # Check for dumper
      trashOffset = @$(".trash").offset()
      if event.pageX > trashOffset.left and event.pageY > trashOffset.top
        item.data("model").destroy()

    render: ->
      # TODO: Add toolbar

      return this
