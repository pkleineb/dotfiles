return {
    "luk400/vim-jukit",
    ft = {"py", "ipynb"},

    keys = {
        -- Remove original binding
        { "<leader>ts", false },
        -- Add new binding
        { "<leader>jt", function() vim.fn["jukit#splits#term"]() end, desc = "Jukit Terminal Split" },
        { "<leader>os", function() vim.fn["jukit#splits#output"]() end, desc = "Jukit Open Output" },
        { "<leader>np", function() vim.fn["jukit#convert#notebook_convert"]("jupyter-notebook") end, desc = "Jukit convert notebook file" },
    },
}
