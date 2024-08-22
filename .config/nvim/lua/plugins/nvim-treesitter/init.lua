return {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    dev = true,

    opts = {
        -- ensure_installed = { "rust", "html", "css", "javascript", "python", "kdl" },
        -- sync_install = false,

        highlight = {
            enable = true,
        },

        indent = {
            enable = true,
        },
    },
}
