namespace "Views", (Views) ->
  class Views.Room extends Backbone.View
    className: "room"

    initialize: ->
      @collection = @model.instances()

      @collection.on "add", @instanceAdded

    instanceAdded: (instance) =>
      {x, y, width, height} = instance.attributes

      html = JST["instance"]()
      instanceElement = $(html).css
        backgroundImage: instance.imageUrl()
        left: x
        top: y
        width: width
        height: height
      .data("model", instance)

      @$el.append instanceElement

    render: =>
      @$el.empty()

      @collection.each @instanceAdded

      $("body").append @$el

      return this
