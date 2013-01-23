namespace "Views", (Views) ->
  class Views.Toolbar extends Backbone.View
    className: "toolbar"

    initialize: ->

    currentTool: ->
      @collection.first()

    render: ->
      @$el.empty()

      @collection.each (tool) =>
        @$el.append JST["tool"](tool.attributes)

      return this
