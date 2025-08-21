require("nvchad.configs.lspconfig").defaults()

local servers = {
  html = {},
  cssls = {},

  pyright = {
    settings = {
      python = {
        analysis = {
          -- Pyright сам ищет пути к библиотекам, установленным в виртуальном окружении
          autoSearchPaths = true,
          -- Строгость проверки типов: off/basic/strict - отключить / базовая (не требует аннотаций) / строгая (требует аннотаций)
          typeCheckingMode = "basic",
          -- Разрешить pyright заглядывать в код библиотек, а не только pyi-стабы - улучшает автодополнение и проверку типов, если стабы отсутствуют или не полны 
          useLibraryCodeForTypes = true,
          -- Режим диагностики -- openFilesOnly / workspace - анализируются только открытые файлы / все файлы в проекте 
          -- Проблемы всех файлов в проекте можно увидеть с помощью :Telescope diagnostics 
          -- А если включить Ruff и отключить диагностику у pyright совсем (off), то в :Telescope diagnostics можно увидеть диагностику ruff 
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
