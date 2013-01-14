namespace "Views", (Views) ->
  class Views.Room extends Backbone.View
    className: "room"

    initialize: ->
      @collection = @model.instances()

      @collection.on "add", @instanceAdded

    instanceAdded: (instance) =>
      {x, y, width, height} = instance.attributes

      html = JST["instance"]()
      instance = $(html).css
        backgroundImage: instance.imageUrl()
        left: x
        top: y
        width: width
        height: height

      @$el.append instance

    render: =>
      @$el.empty()

      @collection.each @instanceAdded

      $("body").append @$el

      return this
