return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
    -- загрузить conform если открываем python файл 
    ft = "python",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
  --
  --
  -- romz987 python debugger 
  {
    -- основной плагин, который реализует DAP-клиент
    "mfussenegger/nvim-dap",
    -- lazy загрузить его при открытии любого python-файла  
    ft = "python",

    -- для него должны быть так же установленны зависимости 
    dependencies = {
      -- графический интерфейс для DAP 
      {
        "rcarriga/nvim-dap-ui",
        opts = {},
        keys = require("plugins.nvim-dap.nvim-dap-ui.nvim-dap-ui-keys").keys,
        -- этот плагин так же имеет собственные зависимости
        -- плагин nvim-neotest/nvim-nio предназначен для работы с асинхронными операциями и улучшения производительности
        dependencies = { "nvim-neotest/nvim-nio" },
        -- так же чуть позже напишем конфигурацию 
        config = function (_, opts)
          require("plugins.nvim-dap.nvim-dap-ui.nvim-dap-ui-config").setup(opts)
        end,
      },
      -- плагин для отображения значения переменных прямо в коде
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },

    -- нужно "назначить" hotkeys для управления отладкой 
    keys = require("plugins.nvim-dap.nvim-dap-keys").keys,

    -- и прописать конфигурацию
    config = function ()
      -- подсветка строки, где выполнение остановилось
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      -- setup dap config by VsCode launch.json file
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      -- DAP читает launch.json с помощью plenary
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end
    end,
  },

  -- это еще не все, потребуется установить еще один плагин, а также debugpy с помощью Mason
  -- и я забыл откомментировать сам плагин
  -- nvim-dap-python предназначен для интеграции debugpy - предоставляет инструменты для управления процессом отладки python-кода прямо в neovim
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    keys = require("plugins.nvim-dap.nvim-dap-python.nvim-dap-python-keys").keys,

    config = function ()
      -- указываем путь к интерпретатору python внутри виртуального окружения пакета debugpy
      -- автоматически созданного Mason при установке debugpy.
      -- vim.fn.stdpath("data") возвращает абсолютный путь к директории ~/.local/share/nvim,
      -- в которю Mason устанавливает свои пакеты
      -- "/mason/packages/debugpy/venv/bin/python" - это путь непосредственно к исполняемому файлу интерпретатора внутри пакета debugpy
      local python_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      -- передаем путь к интерпретатору в nvim-dap-python
      -- этот интерпретатор используется для запуска debugpy
      require("dap-python").setup(python_path)
    end,
  },

  -- красивый и правильный markdown в neovim
  -- https://github.com/MeanderingProgrammer/render-markdown.nvim?tab=readme-ov-file
  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
       dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
       ft = "markdown",
    ---@module 'render-markdown'
    --@type render.md.UserConfig
    opts = {},
  },


  -- подхватить конфигурацию nvim-tree  
  {
    "nvim-tree/nvim-tree.lua",
    opts = function(_, opts)
      local user_opts = require("configs.nvimtree")
      return vim.tbl_deep_extend("force", opts, user_opts)
    end,
  },
}

