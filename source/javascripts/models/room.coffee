namespace "Models", (Models) ->
  Models.Room = (I={}) ->
    Object.reverseMerge I,
      name: "Untitled"
      uuid: Math.uuid()
      instances: []
      backgroundColor: "gray"

    # Re-hydrate instances
    I.instances = I.instances.map Models.Instance

    self = Models.Base(I).extend
      instances: ko.observableArray(I.instances)
      addInstance: (instance) ->
        self.instances.push(instance)
      removeInstance: (instance) ->
        self.instances.remove(instance)
      toJSON: ->
        name: self.name()
        uuid: self.uuid()
        instances: self.instances().invoke "toJSON"
        backgroundColor: self.backgroundColor()

    self.observe "name", "uuid", "backgroundColor"

    return self
