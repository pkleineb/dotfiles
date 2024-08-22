return {
    "andweeb/presence.nvim",
    lazy = false,

    config = function ()
        require("presence").setup({
            neovim_image_text = "Wait I am still configuring my dotfiles",
            enable_line_number = true,

            buttons = {
                { label = "GitHub Profile", url = "https://github.com/pkleineb" },
                { label = "Crazy cofings", url = "https://github.com/pkleineb/dotfiles" },
            },
        })
    end
}
