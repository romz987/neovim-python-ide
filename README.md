# Neovim Python IDE

## Содержание

- [Часть 1: Установка и настройка NvChad](#)
    - [Установка NvChad](#)
    - [Структура файлов NvChad](#)
    - [Конфигурируем NvChad](#)
- [Часть 2: Установка и настройка инструментов разработчика](#)
    - [Настройка Treesitter](#)
    - [Установка и настройка LSP-сервера pyright](#)
    - [Установка и настройка линтера ruff](#)
    - [Установка и настройка форматтера black](#)
- [Часть 3: Дебаггер](#)
    - [Установка и настройка](#)
    - [Как отлаживать Django](#)
    - [Как отлаживать Flask](#)
    - [Как отлаживать FastAPI](#)
- [Часть 4: Установка и настройка pre-commit pipeline](#)
- [Плагины NvChad по умолчанию](#плагины-nvchad-по-умолчанию)
- [Другие полезные плагины](#другие-полезные-плагины)
- [Список использованных материалов](#список-использованных-материалов)

- [Приложение 1: Как работает подсветка синтаксиса](#)
- [Приложение 2: Как работает автодополнение](#)
- [Приложение 3: Как работает LSP](#)
- [Приложение 4: Как работает отладка](#)

- [Дополнительные советы](#)

## Часть 1: Установка и настройка NvChad

### Установка NvChad

Происходит в соответствии с официальной документацией NvChad

Перед установкой необходимо удалить предыдущие конфигурации Neovim и убедиться в наличии следующих зависимостей:

- `Nerd Font` - требует в качестве шрифтов терминала.
- `Tree-sitter-cli` — требуется для установки парсеров nvim-treesitter
- `Ripgrep` — для grep-поиска в Telescope
- `GCC` — для сборки native-расширений

Установка выполняется одной командой:
```bash
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
```

NvChad поставляется с предустановленным набором плагинов.  
После клонирования репозитория и запуска Neovim менеджер плагинов Lazy.nvim автоматически загрузит и установит все предустановленные плагины.  

**Важно:** чтобы LSP-серверы для Lua (lua-language-server, css-lsp, html-lsp) и форматтер stylua установились автоматически, перед выполнением следующих действий откройте любой Lua-файл — например, init.lua из директории `~/.config/nvim`.  

Для установки LSP-серверов, линтеров и Treesitter-парсеров, добавленных в конфигурацию по умолчанию, выполните в командном режиме:
```bash
:MasonInstallAll
:TSInstallAll
```

Полный список плагинов по умолчанию с описанием представлен в разделе [Плагины NvChad по умолчанию](#плагины-nvchad-по-умолчанию).

После завершения установки удалите директорию .git из ~/.config/nvim — репозиторий NvChad starter больше не нужен.

### Структура файлов NvChad


| Директория | Назначение |
|---|---|
| `~/.config/nvim/` | Пользовательские конфигурации — основная рабочая директория |
| `~/.local/share/nvim/` | Установленные плагины (Lazy, Mason) |
| `~/.local/state/nvim/` | Файлы состояния: история, undo, swap, логи |


### Конфигурируем NvChad

Основной файл конфигурации: `~/.config/nvim/lua/chadrc.lua`  

Получить полную справку по его структуре:
```bash
:h nvui
```

В `chadrc.lua` конфигурируются:

- Цветовая схема (раздел base46)
- Элементы пользовательского интерфейса:
    - Стиль окна автодополнения (cmp)
    - Стиль Telescope
    - Стиль statusline
    - Стиль tabufline
- Параметры плавающего терминала (раздел term)
- Приветственное окно (nvdash)
- Стиль cheatsheet
- Настройки `colorify.nvim` — отображение образцов цветов в буфере
- Пакеты Mason для автоматической установки

`hl_override и hl_add`  

Раздел `hl_override` в base46 полностью переопределяет стили для указанных `highlight-групп`.  
Раздел `hl_add` — дополняет существующие стили новыми, не заменяя их.  
Просмотреть доступные для переопределения группы можно командами:  
```bash
## список стандартных групп
:help highlight-groups
## текущие группы и их стили
:hi
```

После внесения изменений в `chadrc.lua` выполнить для применения конфигурации:
```bash
:Lazy sync
:MasonInstallAll
```

## Часть 2: Установка и настройка инструментов разработчика

### Treesitter

Установка необходимых парсеров:
```bash
:TSInstall python lua html css json jsonc bash markdown markdown_inline yaml toml dockerfile
```

### Установка pyright, ruff и black

Добавить в `chadrc.lua`:  
```lua
M.mason = {
  pkgs = {
    ...
    "pyright",
    "ruff",
    "black",
  }
 ...
}
```

Выполнить:  
```bash
:MasonInstallAll
```

### Настройка pyright

### Настройка ruff

### Настройка black

## Часть 3: Установка и настройка дебаггера

## Часть 4: Установка и настройка pre-commit pipeline

## Плагины NvChad по умолчанию

### Плагины NvChad

Базовые плагины фреймворка NvChad, обеспечивающие его работу, темы и пользовательские меню.


| Плагин | Описание | Ссылка |
|--------|----------|--------|
| nvchad/base46 | Движок тем NvChad: управление цветовыми схемами, переопределение highlight-групп, интеграции с плагинами | https://github.com/NvChad/base46 |
| nvchad/ui | UI-слой NvChad: statusline, tabufline (вкладки + буферы), cheatsheet, theme switcher, updater | https://github.com/NvChad/ui |
| nvzone/menu | Библиотека для создания всплывающих меню (используется minty и другими nvzone-плагинами) | https://github.com/nvzone/menu |
| nvzone/volt | Фреймворк для создания реактивных UI-компонентов внутри Neovim | https://github.com/nvzone/volt |
| nvzone/minty | Инструменты подбора и манипуляции цветом: команды Huefy и Shades | https://github.com/nvzone/minty |


### Плагины для автодополнения

Система автодополнения (completion) и всё, что с ней связано: движок сниппетов, источники, авто-закрытие скобок.


| Плагин | Описание | Ссылка |
|--------|----------|--------|
| hrsh7th/nvim-cmp | Основной фреймворк автодополнения (completion engine) | https://github.com/hrsh7th/nvim-cmp |
| L3MON4D3/LuaSnip | Движок сниппетов с поддержкой сложных преобразований | https://github.com/L3MON4D3/LuaSnip |
| rafamadriz/friendly-snippets | Коллекция готовых сниппетов для множества языков и фреймворков | https://github.com/rafamadriz/friendly-snippets |
| windwp/nvim-autopairs | Автоматическое закрытие скобок, кавычек и других парных символов | https://github.com/windwp/nvim-autopairs |
| saadparwaiz1/cmp_luasnip | Источник сниппетов LuaSnip для nvim-cmp | https://github.com/saadparwaiz1/cmp_luasnip |
| hrsh7th/cmp-nvim-lua | Источник API Neovim Lua для nvim-cmp | https://github.com/hrsh7th/cmp-nvim-lua |
| hrsh7th/cmp-nvim-lsp | Источник LSP-завершений для nvim-cmp | https://github.com/hrsh7th/cmp-nvim-lsp |
| hrsh7th/cmp-buffer | Источник завершений из содержимого открытых буферов для nvim-cmp | https://github.com/hrsh7th/cmp-buffer |
| FelipeLema/cmp-async-path | Источник путей файловой системы для nvim-cmp | https://codeberg.org/FelipeLema/cmp-async-path |


### User Interface плагины

Плагины, отвечающие за визуальное оформление, навигацию и отображение информации.


| Плагин | Описание | Ссылка |
|--------|----------|--------|
| nvim-tree/nvim-web-devicons | Набор иконок для типов файлов (используется nvim-tree, telescope и др.) | https://github.com/nvim-tree/nvim-web-devicons |
| nvim-tree/nvim-tree.lua | Файловый менеджер в виде дерева директорий | https://github.com/nvim-tree/nvim-tree.lua |
| folke/which-key.nvim | Всплывающая подсказка по доступным хоткеям при нажатии лидера | https://github.com/folke/which-key.nvim |
| lukas-reineke/indent-blankline.nvim | Вертикальные линии отступов (indent guides) и подсветка scope-блоков | https://github.com/lukas-reineke/indent-blankline.nvim |


### Инструменты 

Инструменты для разработки: LSP, форматирование, подсветка синтаксиса.


| Плагин | Описание | Ссылка |
|--------|----------|--------|
| mason-org/mason.nvim | Менеджер внешних инструментов: LSP-серверы, DAP-адаптеры, линтеры, форматтеры | https://github.com/mason-org/mason.nvim |
| neovim/nvim-lspconfig | Стандартная конфигурация LSP-серверов для Neovim | https://github.com/neovim/nvim-lspconfig |
| stevearc/conform.nvim | Форматирование кода с поддержкой множества форматтеров и LSP-fallback | https://github.com/stevearc/conform.nvim |
| nvim-treesitter/nvim-treesitter | Синтаксический парсер: улучшенная подсветка, навигация по AST, инкрементальный выбор | https://github.com/nvim-treesitter/nvim-treesitter |


### Другое 

Плагины общего назначения, не вошедшие в предыдущие категории.


| Плагин | Описание | Ссылка |
|--------|----------|--------|
| nvim-lua/plenary.nvim | Набор Lua-утилит (JSON, Path, async-операции, job control) — зависимость многих плагинов | https://github.com/nvim-lua/plenary.nvim |
| nvim-telescope/telescope.nvim | Универсальный fuzzy-поиск: файлы, grep, diagnostics, git, LSP и сотни расширений | https://github.com/nvim-telescope/telescope.nvim |
| lewis6991/gitsigns.nvim | Git-значки в gutter-колонке: добавлено, изменено, удалено, blame, hunk-навигация | https://github.com/lewis6991/gitsigns.nvim |


## Другие полезные плагины

### AI-ассистент

`yetone/avante.nvim`

[avante github page](https://github.com/yetone/avante.nvim)

### Навигация и редактирование

`folke/flash.nvim`

Быстрые прыжки по тексту.  
Улучшенные motions f/t.  

[flash github page](https://github.com/folke/flash.nvim)

`kevinhwang91/nvim-ufo`

Улучшает встроенный folding.  

[neovim ufo github page](https://github.com/kevinhwang91/nvim-ufo)

`mg979/vim-visual-multi`

Полноценное multi-cursor редактирование.  
Одновременная работа с несколькими курсорами и выделениями.  

[vim-visual-multi github page](https://github.com/mg979/vim-visual-multi)

`hinell/duplicate.nvim`

Удобное дублирование строк и выделенных блоков.  

[duplicate github page](https://github.com/hinell/duplicate.nvim)

`fedepujol/move.nvim`

Перемещение строк и блоков с возможностью сохранения индентации.

[move github page](https://github.com/fedepujol/move.nvim)

### Уведомления и интерфейс

`folke/noice.nvim`

Заменяет стандартный UI для сообщений, командной строки и popup-меню:  

- Отображает уведомления с помощью notify.nvim  
- Позволяет гибко маршрутизировать сообщения от neovim и отображать их в разных представлениях  
- Ведёт историю сообщений  
- Добавляет UI для Command line  
- Добавляет UI для поиска  
- Добавляет UI для Hover-документации от LSP  
- Добавляет UI для LSP signature help  
- Подсвечивает синтаксис Vim/Lua прямо в Commad line  
- Отображает длинный вывод команд в обычных буферах/split  
- Подсвечивает синтаксис Vim/Lua прямо в Command line  

[noice github page](https://github.com/folke/noice.nvim)

`lukas-reineke/indent-blankline.nvim`

Подсветка направляющих отступов и вложенности.  
Улучшает читаемость кода.

[indent-blankline github page](https://github.com/lukas-reineke/indent-blankline.nvim)

`HiPhish/rainbow-delimiters.nvim`

Подсвечивает вложенные разделители, теги и ключевые слова разными цветами.  
Улучшает читаемость кода (особенно html и jsx).  

[rainbow-delimiters github page](https://github.com/hiphish/rainbow-delimiters.nvim)

`folke/todo-comments.nvim`

Подсвечивает теги комментариев (FIX, TODO, NOTE, PERF, HACK, WARNING).
Улучшает читаемость кода.

[todo-comments github page](https://github.com/folke/todo-comments.nvim)

`karb94/neoscroll`

Добавляет плавную анимацию прокрутки в Neovim вместо резких скачков при перемещении по файлу.  

[neoscroll github page](https://github.com/karb94/neoscroll.nvim)

`sphamba/smear-cursor.nvim`

Дополнительная анимация для курсора.  
Позволяет лучше замечать перемещения курсора.  

[smear-cursor github page](https://github.com/sphamba/smear-cursor.nvim)

`MeanderingProgrammer/render-markdown.nvim`

Рендеринг Markdown прямо в буфере Neovim.  

[render-markdown github page](https://github.com/MeanderingProgrammer/render-markdown.nvim)

### lsp интеграция

`nvimdev/lspsaga.nvim`

Улучшает встроенный LSP-интерфейс Neovim, предоставляя более удобный UI для навигации, диагностики, code actions и работы с символами:

- Показывает диагностику LSP в удобных float-окнах и позволяет быстро переходить между ошибками  
- Даёт Finder для поиска определений, ссылок и других LSP-символов  
- Добавляет Peek Definition / Peek Type Definition — просмотр определения прямо во всплывающем окне  
- Улучшает Hover — отображение документации и информации о символе  
- Добавляет удобный Rename с предварительным просмотром изменений и поиском/заменой по проекту  
- Показывает Code Actions в отдельном UI с live preview  
- Показывает Lightbulb при наличии доступных Code Actions  
- Добавляет Call Hierarchy — поиск входящих и исходящих вызовов  
- Показывает реализации интерфейсов и позволяет быстро переходить к ним  
- Добавляет Outline — дерево символов текущего файла  
- Добавляет Breadcrumbs — текущий путь по символам в winbar  
- Улучшает переходы Go to Definition / Type Definition визуальным beacon-индикатором  
- Добавляет float terminal  
- Предоставляет единый настраиваемый UI для LSP float-окон, границ, иконок и preview  

[lspsaga github page](https://github.com/nvimdev/lspsaga.nvim)

`folke/trouble.nvim`

Предоставляет единый удобный UI для диагностики и результатов LSP, Quickfix и Location List.  
Удобно для копирования сообщений lsp и линтера.

[trouble github page](https://github.com/folke/trouble.nvim)

### git интеграция

Git-клиент внутри Neovim

`NeogitOrg/neogit`

[neogit github page](https://github.com/NeogitOrg/neogit)

## Список использованных материалов

neovim: [neovim official website](https://neovim.io/)  
neovim: [neovim github page](https://github.com/neovim/neovim)  
  
nvchad: [nvchad official website](https://nvchad.com/)  
nvchad: [nvchad github page](https://github.com/NvChad/NvChad)  

dotfyle - discover neovim plugins: [dotfyle](#https://dotfyle.com/)  

## Приложение 1: Как работает подсветка синтаксиса

## Приложение 2: Как работает автодополнение

## Приложение 3: Как работает LSP

## Приложение 4: Как работает отладка

## Дополнительные советы

### Корректное определение типов файлов на примере docker-compose

Как распознаётся тип текущего файла:
```bash
:set filetype?
```

Создать файл filetypes.lua в `~/.config/nvim/lua/`:  

```lua
vim.filetype.add({
  filename = {
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["compose.yaml"] = "yaml.docker-compose",
  },
})
```

Добавить в `init.lua`:  
```lua
...
require "filetypes"
...
```

Перепроверить `filetype?`
