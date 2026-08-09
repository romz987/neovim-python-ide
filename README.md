# Neovim Python IDE

## Содержание

- [Часть 1: Установка и настройка NvChad](#)
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

## Часть 2: Установка и настройка инструментов разработчика

### Настройка Treesitter

### Установка и настройка LSP-сервера pyright

### Установка и настройка линтера ruff

### Установка и настройка форматтера black

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

### Markdown

Рендеринг Markdown прямо в буфере Neovim

`MeanderingProgrammer/render-markdown.nvim`

[render-markdown github page](https://github.com/MeanderingProgrammer/render-markdown.nvim)

### Git

Git-клиент внутри Neovim

`NeogitOrg/neogit`

[neogit github page](https://github.com/NeogitOrg/neogit)

### Фолдинг

Модный фолдинг

`kevinhwang91/nvim-ufo`

[https://github.com/kevinhwang91/nvim-ufo]

### Скроллинг

Плавный скроллинг

`karb94/neoscroll`

[https://github.com/karb94/neoscroll.nvim]

### Курсор

Модный курсор

`sphamba/smear-cursor`

[https://github.com/sphamba/smear-cursor.nvim]

### Уведомления

Система уведомлений для Neovim

`rcarriga/nvim-notify` или `noice.nvim`

[nvim-notify github page](https://github.com/rcarriga/nvim-notify)

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

