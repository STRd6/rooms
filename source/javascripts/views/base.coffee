namespace "Views", (Views) ->
  class Views.Base extends Backbone.View
    # TODO: @include "Core"
    @new = (args...) ->
      new @ args...
