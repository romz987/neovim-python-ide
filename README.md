# Python IDE based Neovim + NvChad

Autumn, 2025

## Abstracts

Руководство по сборке Python IDE на базе текстового редактора Neovim и набора конфигураций NvChad для Linux-пользователей.
Предствляет собой синтез документации NvChad и Neovim, личного опыта и разнообразных сторонних мануалов и гайдов по этой или смежной темам.
Ссылки на все источники или просто полезные ресурсы находятся в разделе Bibliography.

## Table of Contents

- [Directory structure](#Directory-structure)
- [How to use this document](#How-to-use-this-document)
- [Part 1: Installing and configuring NvChad](<>)
  - [Installing NvChad](#Installing-NvChad)
  - [Default plugins](#Default-plugins)
  - [Configuring NvChad](#Configuring-NvChad)
- [Part 2: Installing developer tooling](<>)
  - [Treesitter](#Treesitter)
  - [LSP-server](#LSP-server)
  - [Linter](<>)
  - [Formatter](<>)
- [Part 3: Pre-commit pipeline](<>)
- [Part 4: Debugger](<>)
- [Part 5: Additional tools](<>)
  - [Notifications](<>)
  - [Git](<>)
  - [Markdown](<>)
- [Bibliography](#Bibliography)
- [Annex A: How autocompletion works](#Annex-A)
- [Annex B: How LSP works](#Annex-B)
- [Annex C: jedi vs pyright](#Annex-B)
- [Annex D: Debugging](#Annex-D)
- [Tips and tricks](#Tips-and-tricks)
  - [LSP messages](#LSP-messages)

## Directory structure

```
nvim-python-ide
.
├──   tooling/
├──   basics/
├──   configs/
├──   images/
├──   python-project-configs/
└──   README.md
```

**tooling**\
Документация по используемому набору инструментов разработчика

**basics**\
Прочие документы

**configs**\
Мои конфигурации (из директории ~/.config/nvim/) с подробными комментариями

**images**\
Используемые изображения (svg, png)

**python-project-configs**\
Мои конфигурационные файлы pyproject.toml и .pre-commit-config.yaml

## How to use this document

**Из каких этапов состоит сборка Neovim в качестве Python IDE и какие для них характеры особенности**

> [!WARNING]
> Материал находится в процессе написания

Читать и делать последовательно - так как это представлено в документе.
Эффективнее всего будет использовать мой мануал в совокупности с документацей NvChad, Lazy и соответствующих плагинов.

Документ содержит приложения (Annexes) с иллюстрациями или простыми пояснениями того, что я счел важным обозреть подробнее.

Директория basics возможно будет содержать какие-нибудь дополнительные документы, например о том, что такое IDE и что такое редактор кода.

______________________________________________________________________

## Part 1: Installing and configuring NvChad

### Installing NvChad

**Шаг первый:**
Первичная установка NvChad проста - достаточно следовать инструкциям в документации на веб-сайте NvChad:

- Удалить все остальные текущие конфигурации и плагины Neovim
- Проверить, что установлена совместимая (современная) версия Neovim
- Убедиться, что установлен Ripgrep (чтобы работал поиск в Telescope)
- Убедиться, что установлена актуальная версия GCC

**Шаг второй:**
Непосредственно установка NvChad выполняется командой:

```bash
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
```

> [!NOTE]
>
> Mason - это менеджер пакетов для Neovim.\
> С его помощью мы можем управлять lsp-серверами, линтерами, форматтерами и дебаггерами.

Следующим шагом документация NvChad рекомендует выполнить в командном режиме:

```
:MasonInstallAll.
```

**Но мы сделаем это чуточку позже - иначе все пойдет не так, как мы ожидаем и это изъян документации NvChad.**

**Шаг третий:**
Перезапустим(!) Neovim и выполним в командном режиме:

```
:checkhealth 
```

Для того, чтобы убедится что все прошло нормально.

> [!NOTE]
>
> Ошибки с luarocks бояться не стоит - он скорее всего нам не потребуется вовсе

После установки файлы окажутся распределены про трем разным директориям:

```
.
├──   ~/.config/nvim/
├──   ~/.local/share/nvim/ 
└──   ~/.local/state/nvim/
```

**~/.config/nvim**\
Содержит пользовательские конфигурации

**~/.local/share/nvim/**\
Содержит установленные с помощью Lazy и Mason плагины

**~/.local/state/nvim/**\
содержит файлы состояния (история, undo, swap, логи)

В основном мы будем работать только в директории ~/.config/nvim, про остальные достаточно просто знать.

**Далее, есть один интересный момент:**
Чтобы lsp-сервера lua-language-server, css-lsp, html-lsp и lua-formatter stylua у нас установились автоматически,
нам нужно открыть какой-нибудь lua-файл в Neovim (например, init.lua в директории ~/.config/nvim) и **только после этого выполнить в командном режиме:**

```
:MasonInstallAll
```

После чего, согласно руководству на сайте NvChad, нам необходимо переместиться в директорию ~/.config/nvim/ и удалить в ней поддиректорию .git.

### Default plugins

NvChad использует в качестве менеджера плагинов Lazy и поставляется с набором предустановленных плагинов.
Чтобы просмотреть предустановленные плагины выполним :Lazy.

> [!NOTE]
>
> Основной особенностью Lazy является lazy loading - настраиваемая загрузка плагинов по мере необходимости.\
> Поэтому мы увидим, что все плагины разделены на два списка:
>
> 1. Loaded - установленные и загруженные плагины
> 1. Not Loaded - установленные, но не загруженные плагины

Сделаем их короткий обозор и для этого условно разделим плагины на категории.

**NvChad плагины**
| Плагин | Описание |
| ---------------- | ------------------------------------------------------------ |
| `nvchad/base46` | Темы и конфигурации UI для NvChad |
| `nvchad/ui` | Пользовательский интерфейс NvChad (статусная строка, таб-линия и др.) |
| `nvzone/menu` | Контекстное меню в NvChad |

**Плагины для автодополнения**\
*Как работает автодополнение см. Annex A*

| Плагин | Описание |
| ---------------------------------------------------- | --------------------------------------------------- |
| `hrsh7th/nvim-cmp` | Completion engine plugin |
| `L3MON4D3/LuaSnip` | Snippet engine plugin, written in Lua |
| `windwp/nvim-autopairs` | Автоматически вставляет парные символы: `()`, `[]`, `""`, etc |
| `saadparwaiz1/cmp_luasnip` | Source adapter для snippets (LuaSnip) |
| `hrsh7th/cmp-nvim-lua` | Source adapter: Neovim → LSP-server for Lua |
| `hrsh7th/cmp-nvim-lsp` | Source adapter: Neovim → LSP-server for other langs |
| `hrsh7th/cmp-buffer` | Source adapter из текущего буфера |
| `https://codeberg.org/FelipeLema/cmp-async-path.git` | Source adapter для путей (async path) |
| `rafamadriz/friendly-snippets` | Коллекция готовых сниппетов для разных языков (используется с LuaSnip) |

**User Interface плагины**
| Плагин | Описание |
| ------------------------------- | ------------------------------------------------------------ |
| `nvzone/volt` | Инструмент для управления цветовыми схемами |
| `nvzone/minty` | Ещё один инструмент тем (альтернатива Volt) |
| `nvim-tree/nvim-web-devicons` | Иконки для файлов в Neovim |
| `lukas-reineke/indent-blankline.nvim` | Подсветка отступов для лучшей читаемости |
| `lewis6991/gitsigns.nvim` | Значки Git на полях (добавлено, изменено и т. д.) |
| `folke/which-key.nvim` | Подсказки по горячим клавишам |

**Tooling**
| Плагин | Описание |
| ------------------------------------ | ------------------------------------------------------------ |
| `nvim-tree/nvim-tree.lua` | Файловый менеджер |
| `stevearc/conform.nvim` | Автоматическое форматирование кода |
| `mason-org/mason.nvim` | Менеджер для установки LSP, линтеров и т. д. |
| `folke/lazy.nvim` | Менеджер плагинов для Neovim |
| `neovim/nvim-lspconfig` | Настройки LSP (Language Server Protocol) |
| `nvim-telescope/telescope.nvim` | Поиск файлов, текста и др. |
| `nvim-treesitter/nvim-treesitter` | Улучшенный синтаксический анализ и подсветка |

**Other**
| Плагин | Описание |
| ---------------- | ------------------------------------------------------------ |
| `plenary.nvim` | Библиотека для Lua, нужна для работы других плагинов |

### Configuring NvChad

Следующим этапом будет написание конфигурации в файле **~/.config/nvim/lua/chadrc.lua**.\
Для получения подробной справки по написанию конфигурации в этом файле нужно выполнить в командном режиме:

```
:h nvui
```

**В chadrc.lua обычно конфигурируется:**

- Цветовая схема (base46)
- Элементы User Interface:
  - Стиль окна автодополнения (cmp)
  - Стиль окна Telescope
  - Стиль statusline
  - Стиль tabufline
- Плавающее окно терминала (term)
- Приветственное окно Neovim (nvdash)
- Стиль cheatsheat
- Настройки плагина colorify.nvim, который показывает образцы цветов в буфере
- Mason: пакеты для установки по умолчанию
- *некоторые аспекты поведения lsp*

Вприницпе, справка :h nvui дает исчерпывающую информацию по возможностям конфигурации.\
Пример моей **подробно откомментированной конфигурации** можно найти в директории **configs/chadrc.lua**.

**Чем отличается hl_override и hl_add?**\
В hl\_ мы конфигурируем стили для различных элементов интерфейса.\
Все доступные для переопределения элементы можно изучить выполнив:

```
:help highlight-groups - список стандартных групп
:hi - посмотреть текущие группы и их стили
```

hl_override - полностью переопределяет текущие стили для соответствующих элементов.
hl_add - добавляет указанные в этой таблице стили к текущим.

После всех выполненных выше действий, согласно документации NvChad, необходимо выполнить:

```
:Lazy sync
```

______________________________________________________________________

## Part 2: Installing developer tooling

### Treesitter

> [!NOTE]
>
> Из-за lazy loading плагин nvim-treesitter не будет загружен до тех пор,
> пока он не потребуется. Поэтому, прежде чем командовать nvim-treesitter'ом
> нужно открыть какой-нибудь файл (или изменить конфигурацию lazy loading для nvim-treesitter)

В NvChad используется плагин nvim-treesitter для подстветки синтаксиса.

*Как именно это работает можно посмотреть в [Annex A](#Annex-A)*

Для корректной работы nvim-treesitter необходимо установить парсер для конкретного языка.
Мы можем узнать какие парсеры у нас уже установлены выполнив в командном режиме :TSInstallInfo

Парсер для языка Python не предустановлен и далее у нас есть два возможных пути:

**1. Руками установить парсер для Python**\
Для этого нужно просто выполнить в командном режиме :TSInstall python.\
Далее, для корректной работы nvim-treesitter c Python следует перезапустить Neovim.

**2. Изменить конфигурацию**\
В файле ~/.config/lua/plugins/init.lua нужно раскомментировать следующий блок кода и добавить туда "python":

```lua
  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css", "python" -- добавили
  		},
  	},
  },

```

А так же все остальное, что душе угодно.\
После чего перезапустить Neovim.

Этот способ может быть предпочтительней в плане удобства и переносимости конфигурации.

### LSP-server

*Что такое LSP-сервер и как это работает можно посмотреть в [Annex B](#Annex-B)*

Чтобы получить справку по LSP от плагина nvim-lspconfig:

```
:help lspconfig 
:help lspconfig-all 
```

В Mason, во вкладке LSP, доступно достаточно много LSP-серверов в комментарии к которым указан Python.\
Мы рассмотрим только два из них: jedi-language-server и pyright.

#### Установка:

**Способ 1 (предпочтительный)**:\
Добавить jedi-language-server и/или pyright в chadrc.lua

```lua
M.mason = {
  -- список lsp-серверов, линтеров и форматтеров, которые нужно установить
  pkgs = {
    "jedi-language-server",
    "pyright",
  }
  -- список тех, что нужно исключить
  -- skip = {}
}
```

После этого выполнить:

```
:MasonInstallAll
```

**Способ 2 (вручную)**:

```
:MasonInstall pyright
:MasonInstall jedi-language-server
```

#### Подключение

**Способ 1**:\
Простой, без конфигурации.\
В файле lspconfig.lua:

```lua
require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "jedi-language-server" -- или pyright }
vim.lsp.enable(servers)
```

**Способ 2**:\
Когда необходимо прописать конфигурацию для lsp-сервера.\
В файле lspconfig.lua:

```lua
local servers = {
  html = {},
  awk_ls = {},
  bashls = {},

  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          typeCheckingMode = "basic",
        },
      },
    },
  },
}

for name, opts in pairs(servers) do
  vim.lsp.enable(name)  -- nvim v0.11.0 or above required
  vim.lsp.config(name, opts) -- nvim v0.11.0 or above required
end
```

#### Краткий обзор

**jedi-language-server**\
Это минималистичный python lsp-server, главным образом ориентированный на автодополение.

**pyright**\
Это мощный и тонко настраиваемый python lsp-server от microsoft.

Краткое сравнение jedi и pyright можно посмотреть в [Annex C](#Annex-C)

### Linter

**Ruff**\
Краткая информация\
Установка\
Варианты использования\
Конфигурация

### Formatter

**Black**\
Краткая информация\
Установка\
Варианты использования\
Конфигурация

______________________________________________________________________

## Part 3: Pre-commit pipeline

Не обязательно и не относится к Neovim и NvChad, но интересно и очень полезно

______________________________________________________________________

## Part 4: Debugger

______________________________________________________________________

## Part 5: Additional tools

### Notificatios

### Git

### Markdown

## Bibliography

**Neovim**\
[Neovim Web](https://neovim.io/)\
[Neovim GitHub](https://github.com/neovim/neovim)

**NvChad**\
[NvChad Web](https://nvchad.com/)\
[NvChad GitHub](https://github.com/NvChad/NvChad)

**Managers**\
[Mason GitHub](https://github.com/mason-org/mason.nvim)\
[Lazy Web](https://lazy.folke.io/configuration)\
[Lazy GitHub](https://github.com/folke/lazy.nvim?tab=readme-ov-file)

**Tree-sitter**\
[Treesitter lib Web](https://tree-sitter.github.io/tree-sitter/)

**LSP-servers**\
[Pyright Web](https://microsoft.github.io/pyright/#/)\
[Pyright GitHub](https://github.com/microsoft/pyright)\
[Jedi-language-server](https://github.com/pappasam/jedi-language-server)

## Annex A

**Как работает автодополнение в Neovim**

Плагин nvim-treesitter используется для подстветки синтаксиса.
А tree-sitter - это библиотека, которую использует плагин nvim-treesitter для построения синтаксического дерева (AST).

Это работает **приблизительно** так:\
Neovim имеет какой-то текст в буфере, определяет filetype(\*.html, \*.css, \*.lua, \*.etc)., а за подсветкой обращается к nvim-treesitter.\
Nvim-treesitter определяет, есть ли установленный парсер для такого filetype.\
Если такой парсер есть, то передает текст в tree-sitter, который строит синтаксическое дерево (AST).\
И далее, на основе AST nvim-treesitter осуществляет подсветку синтаксиса через Neovim API.

<br>

![nvim-cmp-scheme](./images/autocompletion/nvim-cmp.svg)

## Annex B

**Как работает LSP в Neovim**

**Language server protocol(LSP)** - это протокол обмена данными между **LSP-клиентом** и **LSP-сервером**.\
LSP-клиент встроен в Neovim, а LSP-сервера, специфичные для каждого языка программирования или языка разметки,
устанавливаются отдельно (в нашем случае с помощью Mason).\
LSP-сервер может поддерживать автодолнение кода, диагностику, переход к определению (go to defenition), подсветку
семантических элементов и так далее.\
LSP-сервера отличаются друг от друга по функционалу.

Встроенному LSP-клиенту требуются соотвествующие конфигурации для запуска того или иного установленного LSP-сервера.
Для этого neovim использует плагин nvim-lspconfig, который содержит набор конфигураций для известных ему LSP-серверов,
а так же множество справочной информации касательно LSP-серверов и их конфигураций.

В случае с автодолнением кода встроенный LSP-клиент запрашивает предложения у LSP-сервера, а их отображение происходит
посредством плагина nvim-cmp через source-адаптер cmp-nvim-lsp (или cmp-nvim-lua для lua-language-server).
Во всех остальных случаях LSP-клиент напрямую использует Neovim API.

<br>

![nvim-lsp](./images/lsp/neovim-lsp.svg)

## Annex C

**jedi-language-server vs pyrigh**

## Annex D

**Как работает отладка в Neovim**

**DAP-протокол**\
*Debugger Adapter Protocol*\
Это спецификация согласно которой реализован интерфейс отладчика (сервера) для работы с клиентом.\
Neovim не имеет встроенного DAP-клиента и не поддерживает протокол DAP.

Плагин **nvim-dap** реализует DAP-протокол и является debugger-клиентом для Neovim.\
Самым процессом отладки Python-кода управляет программа Debugpy.\
Neovim "общается" с Debugpy посредством **nvim-dap**.\
Debugpy запускает файл для отладки с помощью системного интерпретатора.\
Debugpy управляет процессом отладки через API интерпретатора (Python trace API?).

Для работы с отладчиком Debugpy в Neovim необходимы еще несколько плагинов, которые по сути являются
надстройками для nvim-dap:

- **nvim-dap-ui**\
  Это user interface для nvim-dap: отображает удобные панели со стеком вызовов, переменными, breakpoints, REPL и так далее.

- **nvim-dap-virtual-text**\
  Показывает значения переменных прямо в коде через Neovim API как виртуальный текст - extmarks (так же, как и сообщения LSP-сервера).

- **nvim-nio**\
  *Зависимость nvim-dap-ui*\
  Библиотека для асинхронного ввода-вывода

- **nvim-dap-python**\
  Автоматически настраивает nvim-dap для работы с Debugpy.

<br>

![nvim-dap](./images/debugging/nvim-dap.svg)

## Tips and tricks

### LSP-messages

**Как копировать сообщения LSP-серверов?**

Сообщения LSP выводятся через **виртуальный текст (extmarks)**. Это не обычный буферный текст, а наложенные элементы, которые Neovim хранит отдельно.

Скопировать текст можно несколькими способами:

1. Открыть диагностику в отдельном окне (обычно появляется снизу):

```
:lua vim.diagnostic.setqflist()
```

2. Открыть диагностику во **floating window** (понадобится мышь):

```
:lua vim.diagnostic.open_float()
```

3. Показать все диагностические сообщения из API:

```
:lua print(vim.inspect(vim.diagnostic.get(0)))
```

4. Показать все сообщения:

```
:messages
```
