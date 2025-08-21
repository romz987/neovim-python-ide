# NvChad - список плагинов по умолчанию

## Содержание

- [Автодополнение](#%D0%90%D0%B2%D1%82%D0%BE%D0%B4%D0%BE%D0%BF%D0%BE%D0%BB%D0%BD%D0%B5%D0%BD%D0%B8%D0%B5)
- [Источники](#%D0%98%D1%81%D1%82%D0%BE%D1%87%D0%BD%D0%B8%D0%BA%D0%B8)

______________________________________________________________________

## Автодополнение

> [!NOTE]
> nvim-cmp

**Main**

| Плагин | Описание |
| ----------------------- | ------------------------------------------------------------- |
| `hrsh7th/nvim-cmp` | Completion engine plugin |
| `L3MON4D3/LuaSnip` | Snippet engine plugin, written in Lua |
| `windwp/nvim-autopairs` | Автоматически вставляет парные символы: `()`, `[]`, `""`, etc |

**Sources**

| Плагин / Source Adapter | Описание |
| ---------------------------------------------------- | --------------------------------------------------- |
| `saadparwaiz1/cmp_luasnip` | Source adapter для snippets (LuaSnip) |
| `hrsh7th/cmp-nvim-lua` | Source adapter: Neovim → LSP-server for Lua |
| `hrsh7th/cmp-nvim-lsp` | Source adapter: Neovim → LSP-server for other langs |
| `hrsh7th/cmp-buffer` | Source adapter из текущего буфера |
| `https://codeberg.org/FelipeLema/cmp-async-path.git` | Source adapter для путей (async path) |


[Как это работает?](https://github.com/romz987/Nvim-python-IDE/blob/master/neovim-basics/05_nvim-cmp.md)
______________________________________________________________________

## Источники

[NvChad GitHub default plugins list](https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/plugins/init.lua)
