return {
    "neovim/nvim-lspconfig",

    dependencies = {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "folke/neodev.nvim",
    },

    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local servers = {
            {
                name = "pylyzer",
            },
            {
                name = "jedi_language_server",
                config = {
                    filetypes = { "python" },
                },
            },
            {
                name = "typos_lsp",
            },
            {
                name = "ruff_lsp",
            },
            {
                name = "lua_ls",
                before_start = function ()
                    require("neodev").setup({})
                end,
                filetypes = { "lua" },
            },
            {
                name = "ts_ls",
                config = {
                    filetypes = { "javascript", "html", "typescript" },
                },
            },
            {
                name = "html",
                config = {
                    filetypes = { "html" },
                },
            },
            {
                name = "cssls",
                config = {
                    filetypes = { "css" },
                },
            },
            {
                name = "vimls",
                config = {
                    filetypes = { "vim", "lua" },
                },
            },
            {
                name = "dartls",
                config = {
                    filetypes = { "dart" },
                },
            },
            {
                name = "clangd",
                config = {
                    filetypes = { "c", "cpp" },
                },
            },
            {
                name = "jdtls",
                config = {
                    filetypes = { "java" },
                },
            },
        }

        -- starts the servers automatically using the default config and specific configs set in the local
        for _, server in ipairs(servers) do
            local config = server.config or {}
            local setup_config = { capabilities = capabilities }
            setup_config = vim.tbl_deep_extend("force", setup_config, config)

            if server.before_start ~= nil then
                server.before_start()
            end

            vim.lsp.config(server.name, setup_config)
            vim.lsp.enable(server.name)
        end

        local luasnip = require("luasnip")
        local cmp = require("cmp")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            sources = {
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "luasnip" },
            },

            mapping = cmp.mapping.preset.insert({
                ["<tab>"] = cmp.mapping.select_next_item(),
                ["<S-tab>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.scroll_docs(4),
                ["<C-k>"] = cmp.mapping.scroll_docs(-4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
            })
        })
    end,
}
