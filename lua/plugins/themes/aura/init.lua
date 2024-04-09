return {
    "baliestri/aura-theme",
    name = "aura-theme",
    priority = 1000,

    lazy = true,

    config = function(plugin)
        vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
    end
}
