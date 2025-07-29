require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- romz987 conform format buffer 
map("n", "<leader>fb", function()
  vim.cmd("ConformFormat")
end, { desc = "Format buffer with conform" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
