return {
    "lervag/vimtex",
    ft = "tex",

    init = function ()
        vim.cmd("filetype plugin indent on")
        vim.cmd("syntax enable")

        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtext_fold_enabled = true

        vim.g.vimtex_compiler_latexmk = {
            options = {
                '--auxdir=./build',
            }
        }
    end
}
