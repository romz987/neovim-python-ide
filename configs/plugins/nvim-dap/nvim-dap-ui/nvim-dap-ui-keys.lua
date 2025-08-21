local M = {}

M.keys = {
    -- открыть/закрыть интерфейс отладки (панели переменных, стек вызовов и т.д.)
    { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
    -- выполнить команду "eval" (вывод значения переменной под курсором)
    { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
}

return M
