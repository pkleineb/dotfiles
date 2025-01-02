local utils = require("configs.utils")
local defaults = require("configs.defaults")

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
    },
    {
        event = 'FileType',
        args = {
            pattern = {"yaml", "yml", "json", "html", "htmldjango"},
            callback = function()
                vim.opt.tabstop = 2
                vim.opt.shiftwidth = 2
                vim.opt.softtabstop = 2
                vim.opt.expandtab = true
            end
        },
    },
    {
        event = 'BufWritePost',
        args = {
            pattern = '*/lua/*.lua',
            callback = function()
                if vim.fn.getcwd() == vim.fn.stdpath("config") then
                    return
                end
                local cwdLua = vim.fn.getcwd() .. "/lua"
                -- double loading since then all dependencies will have also refreshed
                utils.loadDir(cwdLua)
                utils.loadDir(cwdLua)
                print("Reloaded lua dir")
            end
        },
    },
}

return autocmd
