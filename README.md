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

### Интерфейс и уведомления

`folke/noice.nvim`

Заменяет стандартный UI для сообщений, командной строки и popup-меню:  

- Позволяет гибко маршрутизировать сообщения от neovim и отображать их в разных представлениях  
- Ведёт историю сообщений  
- Добавляет UI для Command line  
- Добавляет UI для поиска  
- Добавляет UI для Hover-документации от LSP  
- Добавляет UI для LSP signature help  
- Подсвечивает синтаксис Vim/Lua прямо в Command line  
- Отображает длинный вывод команд в обычных буферах/split  
- Подсвечивает синтаксис Vim/Lua прямо в Command line  

[nvim-notify github page](https://github.com/rcarriga/nvim-notify)




















### AI-ассистент

`yetone/avante.nvim`

[avante github page](https://github.com/yetone/avante.nvim)

### Подсветка отступов и вложенности

Отображение вертикальных направляющих отступов.
Улучшает читаемость кода.

`lukas-reineke/indent-blankline.nvim`

[indent-blankline github page](https://github.com/lukas-reineke/indent-blankline.nvim)






















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

[neovim ufo github page](https://github.com/kevinhwang91/nvim-ufo)

### Скроллинг

Плавный скроллинг

`karb94/neoscroll`

[neoscroll github page](https://github.com/karb94/neoscroll.nvim)

### Курсор

Модный курсор

`sphamba/smear-cursor`

[smear-cursor github page](https://github.com/sphamba/smear-cursor.nvim)


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

