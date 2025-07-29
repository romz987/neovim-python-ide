local M = {}

function M.setup(opts)
    local dap = require("dap")

    -- Настройка адапатера DAP для python
    dap.adapters.python = {
        -- Использовать debugpy как внешний процесс запуская его через python -m debugpy.adapter
        type = 'executable';
        command = 'python';
        args = { '-m', 'debugpy.adapter' };
    }

    dap.configurations.python = {
        {
            type = 'python';
            -- запускать новую сессию
            request = 'launch';
            -- имя для nvim-dap-ui
            name = 'Start Django Calcoo';
            -- путь к файлу, запускающему проект для откладки
            program = '/home/romz987/Documents/00_YandexDisk/01_DOCS/01_ACADEMY/finalwork/manage.py';
            -- команда (runserver для Django, например)
            args = {'runserver'};
            -- вывод будет внутри терминала Neovim.
            console = 'integratedTerminal';
            -- игнорирует системные/внешние библиотеки.
            justMyCode = true;
        },
    }

    -- Подключаем и настраиваем nvim-dap-ui с переданными опциями (opts из Lazy plugin config).
    local dapui = require("dapui")
    dapui.setup(opts)
    -- Автоматически открываем UI, когда начинается сессия отладки (event_initialized).
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
    end
    -- Закрывает UI, когда отладка завершена (event_terminated) или пользователь вышел (event_exited).
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
    end

    -- Стиль точки останова
    -- Определение знака для точки останова
    vim.fn.sign_define('DapBreakpoint', {text='⬤', texthl='DapBreakpoint', linehl='', numhl=''})
    -- Определение цветовой группы для точки останова
    vim.cmd('highlight DapBreakpoint guifg=#FF0000 ctermfg=red')
end

return M
