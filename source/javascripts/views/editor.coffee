namespace "Views", (Views) ->
  class Views.Editor extends Backbone.View
    className: "editor"

    events:
      "movestart .room .item": "toolStart"
      "move .room .item": "toolMove"
      "moveend .room .item": "toolEnd"

    initialize: ->
      {items, room} = @options

      new Views.ItemPalette
        collection: items
      .render().$el.appendTo(@$el)

      tools = new Collections.Tools [
        Models.Tool.tools.Move
      ]
      (@toolbar = new Views.Toolbar
        collection: tools
      ).render().$el.appendTo(@$el)

      new Views.Room
        model: room
      .render().$el.appendTo(@$el)

      @$el.append JST["trash"]()

      @render()

      @$el.appendTo("body")

    currentTool: ->
      @toolbar.currentTool()

    toolStart: (event) ->
      item = $(event.currentTarget)

      @currentTool().start
        event: event
        item: item

    toolMove: (event) ->
      item = $(event.currentTarget)

      @currentTool().move
        event: event
        item: item

    toolEnd: (event) ->
      item = $(event.currentTarget)

      @currentTool().end
        event: event
        item: item

      # TODO: Generalize drop targets
      # Check for dumper
      trashOffset = @$(".trash").offset()
      if event.pageX > trashOffset.left and event.pageY > trashOffset.top
        item.data("model").destroy()

    render: ->
      # TODO: Add toolbar

      return this
