return {
    dir = "~/Documents/dev/lua/themepicker.nvim",
    --"pkleineb/themepicker.nvim",
    lazy = false,

    keys = {
        { "<leader>t", "<cmd>ThemepickerRun<cr>", desc = "[Themepicker] Constructs Themepicker window" },
    },

    config = function()
        require("themepicker").setup({})
    end
}
