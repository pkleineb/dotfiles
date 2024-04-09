return {
    "neovim/nvim-lspconfig",

    dependencies = {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },

    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local servers = {
            {
                name = "pylsp",
            },
            {
                name = "rust_analyzer",
            },
            {
                name = "lua_ls",
            },
            {
                name = "tsserver",
            },
            {
                name = "html",
            },
            {
                name = "cssls",
            },
            {
                name = "vimls",
            },
        }

        for _, server in ipairs(servers) do
            local config = server.config or {}
            local setup_config = { capabilities = capabilities }

            for key, value in pairs(config) do
                setup_config[key] = value
            end

            lspconfig[server.name].setup(setup_config)
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
