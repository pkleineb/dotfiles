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
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local servers = {
            --{
            --    name = "pylyzer",
            --},
            {
                name = "jedi_language_server",
            },
            --{
            --    name = "ruff_lsp",
            --},
            {
                name = "rust_analyzer",
            },
            {
                name = "lua_ls",
                on_init = function(client)
                require("neodev").setup({})
                local path = client.workspace_folders[1].name
                if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
                    return
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                    -- Tell the language server which version of Lua you're using
                    -- (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT'
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                            -- Depending on the usage, you might want to add additional paths here.
                            -- "${3rd}/luv/library"
                            -- "${3rd}/busted/library",
                        }
                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                        -- library = vim.api.nvim_get_runtime_file("", true)
                    }
                })
                end,
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

        -- starts the servers automatically using the default config and specific configs set in the local
        for _, server in ipairs(servers) do
            local config = server.config or {}
            local setup_config = { capabilities = capabilities }

            for key, value in pairs(config) do
                setup_config[key] = value
            end
            --if server.before_start ~= nil then server.before_start() end
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