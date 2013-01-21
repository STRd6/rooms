namespace "Models", (Models) ->
  class Models.Room extends Backbone.Model
    initialize: ->
      # TODO: Load from data
      @_instances = new Collections.Instances
      # Currently assuming local storage
      @_instances.fetch()

      @_instances.on "change", =>
        @_instances.each (instance) ->
          instance.save()

      @_instances.on "add", (instance) ->
        instance.save()

      @_instances.on "remove", (instance) ->
        instance.destroy()

    instances: ->
      @_instances

    addInstance: (data) ->
      @_instances.add data
