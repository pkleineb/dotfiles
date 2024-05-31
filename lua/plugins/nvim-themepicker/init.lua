return {
    "pkleineb/themepicker.nvim",

    keys = {
        { "<leader>t", "<cmd>ThemepickerRun<cr>", desc = "[Themepicker] Constructs Themepickerw window" },
    },

    config = function()
        require("themepicker").setup({})
    end
}
