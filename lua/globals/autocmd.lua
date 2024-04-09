local utils = require("globals.utils")
local defaults = require("globals.defaults")

local autocmd = {
    {
        event = 'VimEnter',
        args = {
            pattern = '*',
            callback = function()
                vim.cmd(defaults.file_explorer_command)
            end
        }
    },
    {
        event = 'FileType',
        args = {
            pattern = '*',
            callback = function()
                for option, value in pairs(defaults.tab_config) do
                    vim.opt[option] = value
                end
            end
        }
    },
    {
        event = 'FileType',
        args = {
            pattern = 'make',
            callback = function()
                vim.opt.tabstop = 8
                vim.opt.shiftwidth = 8
                vim.opt.softtabstop = 0
                vim.opt.expandtab = false
            end
        },
    }, {
        event = 'BufWritePost',
        args = {
            pattern = '*/lua/*.lua',
            callback = function()
                local fileName = vim.api.nvim_buf_get_name(0)
                utils.reloadLua(fileName)
                vim.notify("reloaded" .. fileName)
            end
        },
    },
}

return autocmd
