require "nvchad.options"

local o = vim.o

-- enable cursorline
o.cursorlineopt ='both'

-- добавить отступ statusline при включенном noice
-- vim.api.nvim_create_autocmd("User", {
--   pattern = "VeryLazy",
--   callback = function()
--     vim.schedule(function()
--       o.cmdheight = 1
--     end)
--   end,
-- })
