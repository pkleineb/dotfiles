local defaults = require('configs.defaults')
local options = require('configs.options')
local autocmd = require('configs.autocmd')
local keymap = require('configs.keymap')

local M = {}

function M.setup() -- setting options
    for option, value in pairs(options) do
        vim.opt[option] = value
    end

    -- autocmd
    for _, auto in ipairs(autocmd) do
        vim.api.nvim_create_autocmd(auto.event, auto.args)
    end

    -- keymaps
    for _, mapping in pairs(keymap) do
        vim.api.nvim_set_keymap("n", mapping[1], mapping[2], {})
    end
end

return M
