return {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,

    config = function ()
        vim.g.rustaceanvim = {
            server = {
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                        }
                    }
                }
            }
        }
        
    end
}
