require("nvchad.configs.lspconfig").defaults()

local servers = {
  html = {},
  cssls = {},
  ruff = {},
  -- markdown
  marksman = {},
  -- toml 
  taplo = {},

  pyright = {
    settings = {
      python = {
        analysis = {
          -- Pyright сам ищет пути к библиотекам, установленным в виртуальном окружении и site-packages
          autoSearchPaths = true,
          -- Строгость проверки типов: off / basic / strict - октлючить / базовая (не требует аннотаций) / строгая (требует аннотаций)
          typeCheckingMode = "basic",
          -- Разрешает pyright заглядывать в реальный код библиотек, а не только в .pyi-стабы (если те отсутствуют или неполны). Это улучшает автодополнение и проверку типов.
          useLibraryCodeForTypes = true,
          -- Режим диагностики - openFilesOnly / workspace - анализируются только открытые файлы / анализируются все файлы в проекте (выявлять ошибки даже в неоткрытых файлах) 
          -- Можно увидеть проблемы всего workspace с помощью :Telescope diagnostics
          -- Если включить Ruff и отключить здесь диагностику, то можно смотреть, что говорит Ruff в :Telescope diagnostics
          diagnosticMode = "workspace",
        },
      },
    },
  },

}

for name, opts in pairs(servers) do
  vim.lsp.enable(name)  -- nvim v0.11.0 or above required
  vim.lsp.config(name, opts) -- nvim v0.11.0 or above required
end

-- read :h vim.lsp.config for changing options of lsp servers 
