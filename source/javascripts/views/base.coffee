#= require pixie/view

namespace "Views", (Views) ->
  class Views.Base extends Pixie.View
    # TODO: @include "Core"
    @new = (args...) ->
      new @ args...
