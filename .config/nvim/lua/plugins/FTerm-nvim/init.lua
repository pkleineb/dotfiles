return {
    "numToStr/FTerm.nvim",

    keys = {
        { "<leader>c", "<cmd>lua require('FTerm').open()<cr>", desc = "[FTerm] toggle terminal" }
    },

    config = function ()
        require("FTerm").setup({
            dimensions = {
                height = 0.7,
                width = 0.7,
            },
        })
    end,
}
