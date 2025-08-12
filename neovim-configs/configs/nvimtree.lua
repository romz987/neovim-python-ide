return {

  -- "адаптивная" ширина окна
  view = {
    width = {
      min = 30,
      max = 60,
      padding = 2,
    },
    cursorline = true,
  },

  -- не преследовать файл в дереве
  update_focused_file = {
    enable = false,
  },

  -- использовать системную корзину при удалении
  trash = {
    cmd = "gio trash",
  },

}
