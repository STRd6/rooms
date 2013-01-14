namespace "Models", (Models) ->
  class Models.Room extends Backbone.Model
    initialize: ->
      @_instances = new Collections.Instances

    instances: ->
      @_instances

    addInstance: (data) ->
      @_instances.add data
