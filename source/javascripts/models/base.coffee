namespace "Models", (Models) ->
  Models.Base = (I={})->

    self = Core(I).extend
      observe: (args...) ->
        args.each (key) ->
          self[key] = ko.observable(I[key])

    return self
