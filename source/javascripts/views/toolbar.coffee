namespace "Views", (Views) ->
  class Views.Toolbar extends Backbone.View
    className: "toolbar"

    events:
      "click .tool": "clickTool"

    initialize: ->
      @activeToolIndex = 0

    clickTool: ->
      @activate($(event.target).index())

    activate: (index) ->
      @activeToolIndex = index
      @$(".tool").eq(index).takeClass("active")

    currentTool: ->
      @collection.at(@activeToolIndex)

    render: ->
      @$el.empty()

      @collection.each (tool) =>
        @$el.append JST["tool"](tool.attributes)

      @activate(0)

      return this
