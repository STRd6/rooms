namespace "Models", (Models) ->
  Models.Toolbar = (I={}) ->
    Object.reverseMerge I,
      tools: []

    I.activeTool = I.tools.first()

    self = Models.Base(I).extend
      tools: ko.observableArray(I.tools)

    self.observe "activeTool"

    return self
