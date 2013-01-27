$ ->
  {Item} = Models
  items = [
    13967
    17138
    8051
    8764
    9032
  ].map (id) ->
    Item
      spriteId: id

  Views.Editor
    items: items

  # TODO: Undo / Redo
  # TODO: Add select, group, delete tools
  # TODO: Add rais/lower tools
