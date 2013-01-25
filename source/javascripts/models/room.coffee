namespace "Models", (Models) ->
  Models.Room = (I={}) ->

    self = Models.Base(I).extend
      instances: ko.observableArray(I.instances)
      addInstance: (instance) ->
        self.instances.push(instance)
      removeInstance: (instance) ->
        self.instances.remove(instance)
      toJSON: ->
        self.instances().invoke "toJSON"

    self.observe "name"

    return self
