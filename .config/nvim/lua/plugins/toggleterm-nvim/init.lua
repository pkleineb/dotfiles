return {
    "akinsho/toggleterm.nvim",

    keys = {
        { "<leader>c", "<cmd>ToggleTerm<cr>", desc = "[toggleterm] Creates floating terminal" }
    },

    opts = {
        direction = "float",
        float_opts = {
            border = "single",
            width = function() return math.floor(vim.o.columns * 0.7) end,
            height = function() return math.floor(vim.o.lines * 0.7) end,
            title_pos = "center",
        }
    },
}
