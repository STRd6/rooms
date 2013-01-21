namespace "Views", (Views) ->
  class Views.Toolbar extends Backbone.View
    className: "toolbar"

    render: ->
      @$el.empty()

      @collection.each (tool) =>
        @$el.append JST["tool"](tool.attributes)

      return this
