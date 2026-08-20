local M = {}

M.keys = {
    -- Установить условный breakpoint (с выражением)
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    -- Включить / выключить обычный breakpoint
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    -- Запустить или продолжить выполнение программы
    { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
    -- Запустить с аргументами (пользовательская функция `get_args` должна быть определена где-то в конфиге)
    -- { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    -- Запустить до курсора
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    -- Перейти к строке (без выполнения)
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    -- Шаг внутрь (step into)
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    -- Переместиться вниз по call stack
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    -- Переместиться вверх по call stack
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    -- Запустить последний запуск
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    -- Шаг наружу (step out)
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    -- Шаг через (step over)
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    -- Поставить выполнение на паузу
    { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
    -- Включить/выключить REPL (интерактивная консоль)
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    -- Показать информацию о текущей отладочной сессии
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    -- Завершить отладочную сессию
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    -- Открыть всплывающее окно с информацией (переменные и т.п.)
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
}

return M
