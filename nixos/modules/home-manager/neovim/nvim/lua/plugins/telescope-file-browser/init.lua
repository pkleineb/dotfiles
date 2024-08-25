return {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },

    keys = {
        { "fe", "<cmd>Telescope file_browser<cr>", desc = "[Telescope-file-browser] open file browser" },
    },
}
