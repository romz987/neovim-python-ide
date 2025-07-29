-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
  -- основная тема
	theme = "github_dark",
  -- темы для быстрого переключения
  theme_toggle = {"material-darker", "github_dark"},
  -- переопределение стилей ( переопределение стандартных highlight групп )
	hl_override = {
    -- цвет и стиль комментариев
		Comment = { fg = "#B69967", italic = true },
		["@comment"] = { fg = "#B69967", italic = true },
    -- цвет выделения (selection) 
    Visual = { bg = "#575C61" },
    -- цвет номеров строк 
    LineNr = { fg = "#8D959C", italic = true },
    -- цвет границ окон
    WinSeparator = { fg = "#505458" },
    -- цвет границы nvim-tree
    NvimTreeWinSeparator = { fg = "#505458" },
    -- цвет границы плаващющего терминала
    FloatBorder = { fg = "#ABB5BE" },
    -- цвет фона терминала
    NormalFloat = { bg = "#2c313a" },

    -- посмотреть все, что доступно для переопределения можно так
    -- :help highlight-groups - список стандартных групп  
    -- :hi - посмотреть текущие группы и их стили
	},

  -- прозрачность
  transparency = true,

  -- не будем переопределять, но я откомментирую 
  -- hl_add = {}, -- добавление новых highlight-групп. ( добавление "стилей" без переопределения )
  -- integrations = {}, -- настройка интеграций тем с плагинами (например, telescope, lsp, и т.д.).
  -- changed_themes = {}, -- кастомизация цветовых схем (base46) по темам.
}

-- элементы интерфеса
M.ui = {
  -- cmp - настройки автодополнения: оставляем default 
  -- telescope - настройки внешнего вида плагина telescope: оставляем default
  -- настройки statusline
  statusline = {
    theme = "vscode"
  },

  -- настройки табов
  tabufline = {
    -- ширина таба
    bufwidth = 25,
  },
}

-- стартовый экран
M.nvdash = { load_on_startup = true }

-- конфигурация плавающего терминала (floating terminal)
M.term = {
  float = {
    relative = "editor", -- позиция относительно окна neovim (а не курсора)
    row = 0.2, -- отступ сверху в процентах (20%)
    width = 0.6, -- ширина окна (60%)
    height = 0.7, -- высота окна (70%)
    border = "rounded", -- сгладить границу
  }
}

-- всплывающая подсказка с аргументами функции во время ее вызова: оставляем default 
-- M.lsp = { signature = true }

-- стили cheatsheet 
M.cheatsheet = {
  theme = "grid",
  -- что исключить из выдачи 
  -- excluded_groups = {}.
}

-- mason 
M.mason = {
  -- список lsp-серверов, линтеров и форматтеров, которые надо установить
  pkgs = {
    "jedi-language-server",
    "pyright",
    "ruff",
    -- markdown
    "marksman",
    -- toml 
    "taplo",
  },
  -- список исключения 
  -- skip = {},
}

-- настройка плагина colorify.nvim, который показывает цвета из кода прямо в редакторе 
M.colorify = {
  -- включить/выключить 
  enabled = true,
  -- способ отображения: fg - цвет текста, bg - цвет фона, virtual - иконка рядом с текстом
  mode = "virtual",
  -- символ, отображаемый в virtual режиме 
  virt_text = "󱓻 ",
  -- hex - подсвечивать hex-цвета, lspvars - подсвечивать переменные с цветами из lsp 
  highlight = { hex = true, lspvars = true },
}

return M
