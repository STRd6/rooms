namespace "Models", (Models) ->
  Models.Room = (I={}) ->

    self = Models.Base(I).extend
      instances: ko.observableArray(I.instances)

    return self
