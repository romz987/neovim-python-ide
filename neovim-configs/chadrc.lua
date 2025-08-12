-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
  -- основная тема
	theme = "tundra",
  -- темы для быстрого переключения
  theme_toggle = {"tundra", "bearded-arc"},

  -- переопределение стилей ( переопределение стандартных highlight групп )
	hl_override = {
    -- цвет и стиль комментариев
		Comment = { fg = "#B69967", italic = true },
		["@comment"] = { fg ="#B69967", italic = true },
    -- цвет выделения (selection)
    Visual = { bg = "#575C61" },
    -- цвет номеров строк
    LineNr = { fg = "#8D959C" },
    -- цвет границ окон
    WinSeparator = { fg = "#505458" },
    -- цвет границы nvim-tree
    NvimTreeWinSeparator = { fg = "#505458" },
    -- цвет границы плавающего терминала
    FloatBorder = { fg = "#ABB5BE" },
    -- цвет фона терминала
    NormalFloat = { bg = "#2C313A" },

    -- посмотреть все, что доступно для переопределения можно так:
    -- :help highlight-groups - список стандартных групп
    -- :hi - посмотреть текущие группы и их стили
	},

  -- прозрачность 
  transparency = true,

  -- не будем переопределять, но я откомментирую
  -- hl_add = {}, - добавление новых highlight групп (добавление "стилей" без переопределения)
  -- integrations = {}, - настройка интеграций тем с плагинами (e.g. telescope, lsp, etc)
  -- changed_themes = {}, - кастомизация цветовых схем (base46) по темам
}

-- элементы интерфейса
M.ui = {
  -- cmp (автодополнение) - оставляем default ("красивше" там все равно нет)
  -- telescope - внешний вид плагина telescope - оставляем default

  -- настройки statusline
  statusline = {
    theme = "vscode",
  },

  -- настройки табов
  tabufline = {
    -- ширина таба
    bufwidth = 35,
  },
}

-- стартовый экран
M.nvdash = { load_on_startup = true }

-- конфигурация плавающего терминала
M.term = {
  float = {
    relative = "editor", -- позиция относительно окна neovim (а не курсора)
    row = 0.2, -- отступ сверху в процентах (20%)
    width = 0.6, -- ширина (60%)
    height = 0.7, -- высота (70%)
    border = "rounded", -- сгладить границу
  }
}

-- всплывающая подсказка с аргументами функции во время ее вызова - оставим default 
-- M.lsp = { signature = true }

-- стили cheatsheet 
M.cheatsheet = {
  theme = "grid",
  -- что исключить из выдачи
  -- excluded_groups = {}
}

-- mason
M.mason = {
  -- список lsp-серверов, линтеров и форматтеров, которые нужно установить
  pkgs = {
    "jedi-language-server",
    "pyright",
    "ruff",
    "black",
    "debugpy",

    -- markdown lsp
    "marksman",
    -- markdown linter - работает в conform
    "markdownlint-cli2",
    -- markdown formatter 
    "mdformat",
  }
  -- список тех, что нужно исключить
  -- skip = {}
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
