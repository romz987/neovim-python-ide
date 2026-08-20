return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- [romz987] подхватить конфигурацию nvim-tree --------------------------------  
  {
    "nvim-tree/nvim-tree.lua",
    opts = function(_, opts)
      local user_opts = require("configs.nvimtree")
      return vim.tbl_deep_extend("force", opts, user_opts)
    end,
  },

  -- [romz987] --- AI Integration  ----------------------------------------------
  -------------------------------------------------------------------------------

  -- Avante AI Client
  {
    "yetone/avante.nvim",
    enabled = true,
    event = "VeryLazy",
    build = vim.fn.has("win32") ~= 0
        and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        or "make",
    version = "*",
    opts = {
      provider = "openai_dpkf",
      providers = {
        -- DeepSeek 4 Flash
        openai_dpkf = {
          __inherited_from = "openai",
          endpoint = "https://api.vsellm.ru/v1",
          model = "deepseek/deepseek-v4-flash",
          api_key_name = "VSELLM_API_KEY",
          max_tokens = 4096,
          -- disable deepthinking  
          extra_body = {
            thinking = {
              type = "disabled",
            },
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "stevearc/dressing.nvim",
    },
  },

  -- [romz987] --- Navigation and Editing ---------------------------------------
  -------------------------------------------------------------------------------
  -- Advanced navigation
  {
    "folke/flash.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- Smooth scrolling
  {
    enabled = true,
    event = "VeryLazy",
    "karb94/neoscroll.nvim",
    opts = {},
  },

  -- Advanced folding
  {
    "kevinhwang91/nvim-ufo",

    dependencies = {
      "kevinhwang91/promise-async",
    },

    event = "BufReadPost",

    init = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,

    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },

    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open all folds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close all folds",
      },
    },
  },

  -- Multi-cursor editing
  {
    enabled = true,
    "mg979/vim-visual-multi",
    branch = "master",

    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<M-n>",
        ["Find Subword Under"] = "<M-n>",
      }
    end,
  },

  -- Dublicate string and blocks
  {
    "hinell/duplicate.nvim",
    enabled = false,
    event = "BufReadPost",
    config = function()
      require("duplicate").setup()
    end,
  },

  -- Move strings and blocks
  {
    "fedepujol/move.nvim",
    enabled = true,

    opts = {
      line = {
        enable = true,
        indent = true,
      },
      block = {
        enable = true,
        indent = true, -- сохраняет/корректирует отступы при перемещении блока
      },
      word = {
        enable = true,
      },
      char = {
        enable = false,
      },
    },

    keys = {
      -- Normal Mode
      { "<A-j>", ":MoveLine(1)<CR>", desc = "Move Line Up" },
      { "<A-k>", ":MoveLine(-1)<CR>", desc = "Move Line Down" },
      { "<A-h>", ":MoveHChar(-1)<CR>", desc = "Move Character Left" },
      { "<A-l>", ":MoveHChar(1)<CR>", desc = "Move Character Right" },
      { "<leader>wf", ":MoveWord(-1)<CR>", mode = "n", desc = "Move Word Left" },
      { "<leader>wb", ":MoveWord(1)<CR>", mode = "n", desc = "Move Word Right" },

      -- Visual Mode
      { "<A-j>", ":MoveBlock(1)<CR>", mode = "v", desc = "Move Block Up" },
      { "<A-k>", ":MoveBlock(-1)<CR>", mode = "v", desc = "Move Block Down" },
      { "<A-h>", ":MoveHBlock(-1)<CR>", mode = "v", desc = "Move Block Left" },
      { "<A-l>", ":MoveHBlock(1)<CR>", mode = "v", desc = "Move Block Right" },
    },
  },

  -- [romz987] --- User Interface -----------------------------------------------
  -------------------------------------------------------------------------------

  -- Notifications
  {
    "folke/noice.nvim",
    enabled = true,
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },

    opts = {
      messages = {
        enabled = true,
        view = "notify",
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext",
      },

      lsp = {
        progress = {
          enabled = true,
          format = "lsp_progress",
          format_done = "lsp_progress_done",
          throttle = 1000 / 30,
          view = "mini",
        },

        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },

      format = {
        notify = {
          { "{message}", hl_group = "NoiceNotifyMessage" },
        },
      },

      views = {
        mini = {
          position = {
            row = -3,
            col = "100%",
          },
        },
      },

      presets = {
        long_message_to_split = true,
        lsp_doc_border = true,
        bottom_search = false,
      },
    },
  },

  -- Highlight indentations and scopes
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- indent - структура отступов всего файла
      -- scope - уровень вложенности текушей строки
      indent = {
        char = "│",
        highlight = "MsgSeparator",
        smart_indent_cap = true,
      },
      scope = {
        enabled = true,
        char = "┆",
        show_start = true,
        show_end = false,
        injected_languages = true,
        highlight = {
          "PreCondit",
          "Label",
        },
        priority = 500,
      },
      exclude = {
        -- Не нужны indent guides в служебных буферах NvChad
        filetypes = {
          "help",
          "lazy",
          "mason",
          "alpha",
          "dashboard",
          "NvimTree",
          "neo-tree",
          "Trouble",
          "notify",
          "toggleterm",
        },
        -- Не показывать в терминалах и прочих специальных buffer
        buftypes = {
          "terminal",
          "nofile",
          "quickfix",
          "prompt",
        },
      },
    },
  },

  -- Advanced syntax highlighting (delimiters, tags and keywords) 
  {
    "HiPhish/rainbow-delimiters.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.g.rainbow_delimiters = {
        -- цвета определены в chadrc.lua hl_add
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  -- Comment tags highlighting
  {
    "folke/todo-comments.nvim",
    enabled = true,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  -- Smear cursor
  {
    "sphamba/smear-cursor.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
      -- Smear cursor when switching buffers or windows.
      smear_between_buffers = true,

      -- Smear cursor when moving within line or to neighbor lines.
      -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
      smear_between_neighbor_lines = true,

      -- Draw the smear in buffer space instead of screen space when scrolling
      scroll_buffer_space = true,

      -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
      -- Smears and particles will look a lot less blocky.
      legacy_computing_symbols_support = false,

      -- Smear cursor in insert mode.
      -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
      smear_insert_mode = true,
    },
    setup = {
      stiffness=0.8,
      trailing_stiffness=0.5,
      distance_stop_animating=0.5
    }
  },

  -- Render markdown in neovim buffer
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = true,
    ft = "markdown",
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },

  -- [romz987] --- LSP integration ----------------------------------------------
  -------------------------------------------------------------------------------
  -- lspsaga
  {
    'nvimdev/lspsaga.nvim',
    enabled = true,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require('lspsaga').setup({})
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    }
  },

  -- trouble
  {
    "folke/trouble.nvim",
    enabled = true,
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- [romz987] --- Python -------------------------------------------------------
  -------------------------------------------------------------------------------
  -- Python Debugger
  {
    "mfussenegger/nvim-dap",
    ft = "python",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        opts = {},
        keys = require("plugins.nvim-dap.nvim-dap-ui.nvim-dap-ui-keys").keys,
        dependencies = { "nvim-neotest/nvim-nio" },
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
  {
    "mfussenegger/nvim-dap-python",
    -- предназначен для интеграции debugpy - предоставляет инструменты для управления процессом отладки python-кода прямо в neovim
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

  -- [romz987] --- JavaScript / TypeScript / html / css -------------------------
  -------------------------------------------------------------------------------
  -- JavaScript / TypeScript linting with eslint_d
  {
    "mfussenegger/nvim-lint",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  -- [romz987] --- Git integration ----------------------------------------------
  -------------------------------------------------------------------------------
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
      "nvim-mini/mini.pick",           -- optional
      "folke/snacks.nvim",             -- optional
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
    }
  },
}
