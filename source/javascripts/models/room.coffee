namespace "Models", (Models) ->
  Models.Room = (I={}) ->
    Object.reverseMerge I,
      name: "Untitled"
      uuid: Math.uuid()

    self = Models.Base(I).extend
      instances: ko.observableArray(I.instances)
      addInstance: (instance) ->
        self.instances.push(instance)
      removeInstance: (instance) ->
        self.instances.remove(instance)
      uuid: ->
        I.uuid
      toJSON: ->
        name: self.name()
        uuid: self.uuid()
        instances: self.instances().invoke "toJSON"

    self.observe "name"

    return self
