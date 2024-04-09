local defaults = require('globals.defaults')
local options = require('globals.options')
local autocmd = require('globals.autocmd')
local keymap = require('globals.keymap')

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
