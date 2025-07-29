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


  -- romz987 nvim-dap with deps
  {
    -- основной плагин, реализуюший DAP-client
    "mfussenegger/nvim-dap",
    -- запускаемся вместе с python файлами
    ft = "python",

    -- зависимости плагина
    dependencies = {
      -- графический интерфейс для DAP
      {
          "rcarriga/nvim-dap-ui",
          opts = {},
          keys = require("plugins.nvim-dap.nvim-dap-ui.nvim-dap-ui-keys").keys,
          dependencies = { "nvim-neotest/nvim-nio" },
          config = function(_, opts)
              require("plugins.nvim-dap.nvim-dap-ui.nvim-dap-ui-config").setup(opts)
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
    keys = require("plugins.nvim-dap.nvim-dap-keys").keys,

    config = function()
      -- Подсветка строки, где выполнение остановилось
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      -- setup dap config by VsCode launch.json file
      -- Настройка поддержки чтения launch.json от VSCode
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")

      -- DAP читает launch.json, убирая комментарии с помощью plenary
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end
    end,
  },
  -- romz987 nvim-dap-python 
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    -- stylua: ignore
    keys = require("plugins.nvim-dap.nvim-dap-python.nvim-dap-python-keys").keys,

    config = function()
      local python_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(python_path)
    end,
  },

}
