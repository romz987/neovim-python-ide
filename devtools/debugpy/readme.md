# Debugger в Neovim для Python


## Содежрание
[Glossary](#Glossary)
[Как это работает?](#Как-это-работает?)
[nvim-dap](#nvim-dap)
[nvim-dap-ui](#nvim-dap-ui)
[launch.json](#launch.json)
[Источники](#Источники)


----
## Glossary
Debug Adapter Protocol (DAP)
Это открытый стандарт взаимодействия между IDE и debugger.
Представлен Microsoft в 2016, до этого каждое IDE поддерживало свой стандарт

Стандартизированные Microsoft базовые возможности отладки, предоставляемые через интерграцию с DAP:
1. Установка точек останова (breakpoints)  
2. Шаг за шагом (step over/into/out)
3. Запуск / перезапуск / остановка отладки
4. Просмотр переменных, стек вызовов


----
## Как это работает?


----
## nvim-dap
nvim-dap — это плагин для Neovim, реализующий клиентскую поддержку Debug Adapter Protocol (DAP).   
Позволяет подключаться к внешним отладчикам, предназначенным для разных языков программирования.  

nvim-dap позволяет:

    1. Запускать приложение в режиме отладки
    2. Подключаться к уже запущенному приложению для отладки
    3. Устанавливать точки останова и пошагово выполнять код (включая step into / over / out)
    4. Изучать текущее состояние приложения (переменные, call stack, watch-выражения и т.д.)

nvim-dap написан на Lua и использует стандартный Neovim API на Lua.
взаимодействует с отладчиком по DAP-протоколу: 

    Запускает внешний отладчик (DAP server) как subprocess.
    Общается с ним через STDIO или TCP, используя протокол DAP (JSON-сообщения).
    Получает ответы и отображает их средствами Neovim (в панелях, плавающих окнах и т.п.).



nvim-dap установка (Lazy):
**base**
```lua
{
  -- основной плагин, реализуюший DAP-client
  "mfussenegger/nvim-dap",
  -- опция LazyVim для рекомендаций 
  -- странная опция - не влияет на поведение neovim и используется только внутри Lazy
  recommended = true,
  -- описание плагиа (предоставляет отладку, требует настроек под каждый язык отдельно)
  desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

  -- зависимости плагина
  dependencies = {
    -- графический интерфейс для DAP
    "rcarriga/nvim-dap-ui",
    -- virtual text for the debugger
    {
       -- плагин отображает значения переменных прямо в коде
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
  },

  -- stylua: ignore
  -- hotkeys для управления отладкой
  keys = {
    -- Установить условный breakpoint (с выражением)
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    -- Включить / выключить обычный breakpoint
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    -- Запустить или продолжить выполнение программы
    { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
    -- Запустить с аргументами (пользовательская функция `get_args` должна быть определена где-то в конфиге)
    { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
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
  },

  config = function()
    -- load mason-nvim-dap here, after all adapters have been setup
    -- Загружаем mason-nvim-dap (если установлен), который помогает автоматически устанавливать адаптеры DAP
    if LazyVim.has("mason-nvim-dap.nvim") then
      require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
    end

    -- Подсветка строки, где выполнение остановилось
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    -- Установка иконок для разных состояний DAP (например, breakpoint, paused и т.д.)
    -- Как это сделать для NvChad?

    -- setup dap config by VsCode launch.json file
    -- Настройка поддержки чтения launch.json от VSCode
    local vscode = require("dap.ext.vscode")
    local json = require("plenary.json")

    -- DAP читает launch.json, убирая комментарии с помощью plenary
    vscode.json_decode = function(str)
      return vim.json.decode(json.json_strip_comments(str))
    end
  end,
}
```

**romz987**
```lua
{
  -- основной плагин, реализуюший DAP-client
  "mfussenegger/nvim-dap",
  ft = "python",

  -- зависимости плагина
  dependencies = {
    -- графический интерфейс для DAP
    {
        "rcarriga/nvim-dap-ui",
        opts = {},
        keys = require("path/to/nvim-dap-ui-keys").keys,
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function(_, opts)
            require("path/to/config").setup(opts)
        end,
    },
    -- плагин отображает значения переменных прямо в коде
    {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
    },
  },
  -- stylua: ignore
  -- hotkeys для управления отладкой
  keys = require("path/to/nvim-dap-keys").keys,

  config = function()
    -- Подсветка строки, где выполнение остановилось
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    -- Установка иконок для разных состояний DAP (например, breakpoint, paused и т.д.)
    for name, sign in pairs(LazyVim.config.icons.dap) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end

    -- setup dap config by VsCode launch.json file
    -- Настройка поддержки чтения launch.json от VSCode
    local vscode = require("dap.ext.vscode")
    local json = require("plenary.json")

    -- DAP читает launch.json, убирая комментарии с помощью plenary
    vscode.json_decode = function(str)
      return vim.json.decode(json.json_strip_comments(str))
    end
  end,
}
```


----
## nvim-dap-ui 
Графическая обёртка для nvim-dap.  
Показывает:  

    Переменные
    Стек вызовов 
    Консоль
    breakpoints
    etc.



----
## launch.json 
launch.json — это конфигурационный файл Visual Studio Code, в котором описывается, как запускать и отлаживать приложение.  
Файл launch.json находится в папке .vscode/ проекта и содержит настройки отладчика, например:
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "python",            // тип адаптера отладки (язык)
      "request": "launch",         // тип запуска: launch или attach
      "name": "Run Python Script", // название конфигурации
      "program": "${file}",        // что запускать (текущий файл)
      "console": "integratedTerminal"
    }
  ]
}
```
Он используется для:

    Запуска приложения с отладкой прямо из редактора

    Указания аргументов, переменных среды, путей к исполняемым файлам

    Подключения к уже запущенному приложению

    Настройки, специфичной для конкретного языка и адаптера

Плагин nvim-dap поддерживает чтение launch.json, чтобы повторно использовать те же настройки отладки, что и в VS Code.
Это позволяет:

    Не дублировать конфигурации вручную

    Совместно использовать один и тот же проект между VS Code и Neovim

    Поддерживать единый формат конфигурации


----
## Источники
Плагины  
1. [nvim-dap](#https://github.com/mfussenegger/nvim-dap)  
2. [nvim-dap-ui](#https://github.com/rcarriga/nvim-dap-ui)  
3. [nvim-dap-virtual-text](#https://github.com/theHamsta/nvim-dap-virtual-text)  
4. [nvim-neotest/nvim-nio](#https://github.com/nvim-neotest/nvim-nio)  
5. [mfussenegger/nvim-dap-python](#https://github.com/mfussenegger/nvim-dap-python)  
6. [debugpy](#https://github.com/microsoft/debugpy)  

Остальное  
1. [A Guide to Debugging Code in Neovim](#https://tamerlan.dev/a-guide-to-debugging-applications-in-neovim/)  
2. [nvim-dap github page](#https://github.com/mfussenegger/nvim-dap)  
3. [LazyVim: DAP Core nvim-dap full specification](#https://www.lazyvim.org/extras/dap/core)  
4. [lazy.nvim plug specification](#https://lazy.folke.io/spec)  
