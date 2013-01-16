namespace "Views", (Views) ->
  class Views.Room extends Backbone.View
    className: "room"

    initialize: ->
      @collection = @model.instances()

      @collection.on "add", @instanceAdded
      @collection.on "remove", @instanceRemoved

    instanceRemoved: (instance) =>
      @$("[cid=#{instance.cid}]").remove()

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
      .attr("cid", instance.cid)

      @$el.append instanceElement

    render: =>
      @$el.empty()

      @collection.each @instanceAdded

      $("body").append @$el

      return this
