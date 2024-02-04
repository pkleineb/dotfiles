"line numbers
set number

set scrolloff=15

set clipboard+=unnamedplus

nnoremap <C-v> "+p

nnoremap <C-c> "+y

let mapleader = "\<Space>"

"plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/vim-easy-align'

"file explorer
Plug 'scrooloose/nerdtree'

"autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"statusbar
Plug 'vim-airline/vim-airline'
"statusbar themes
Plug 'vim-airline/vim-airline-themes'

"auto bracket & quote completion
Plug 'jiangmiao/auto-pairs'

"auto comment line via cmd
Plug 'scrooloose/nerdcommenter'

"auto-formater
Plug 'sbdchd/neoformat'

"multiple cursors
Plug 'mg979/vim-visual-multi'

"fold them functions
Plug 'tmhedberg/SimpylFold'

"colortheme
Plug 'joshdick/onedark.vim'

"closing buffers
Plug 'moll/vim-bbye'

"folds
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'

"lazy git
Plug 'kdheepak/lazygit.nvim'

call plug#end()

"setting colorscheme
syntax on
colorscheme onedark

if !empty($ISVENV)
    let g:NERDTreeChDirMode = 2

    "start with initialized NerdTree
    autocmd vimenter * NERDTree

else
    autocmd vimenter * NERDTree ~/

endif

"auto close NERDTree if last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

nnoremap <Leader>i :NERDTreeFocus<CR>

"vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'violet'

"configure vim airline tabs to work with ctrl + arrow
nnoremap <C-Left> :bprevious<CR>
nnoremap <C-Right> :bnext<CR>
nnoremap <C-Up> :bfirst<CR>
nnoremap <C-Down> :blast<CR>

nnoremap <Leader>q :Bdelete<CR>

function RunFile(ftype, fargs = "")
    if a:ftype == 'python'
        execute '!py -3.11 "%:p" ' . a:fargs

    elseif a:ftype == 'cpp'
	    echo expand("%:p:h") . "/Makefile"
        if filereadable(getcwd() . "/Makefile")
            execute "!make"
            execute "!cd bin && " . a:fargs . ".exe"
        else
            execute "!clang++ %:p " . a:fargs
        endif

    else
        echo 'not recognised language!'
    endif
endfunction

command -nargs=* Run w | call RunFile(&filetype, <q-args>) 

"basic format rules
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1

let $NVIM_COC_LOG_LEVEL = 'debug'

filetype plugin indent on

autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

autocmd FileType cpp set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
autocmd FileType python set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

let g:VM_mouse_mappings = 1
let g:VM_theme = 'iceblue'
let g:VM_highlight_matches = 'underline'

let g:VM_maps = {}
let g:VM_maps["Undo"] = 'u'
let g:VM_maps["Redo"] = '<C-r>'

nnoremap <silent> <leader>gg :LazyGit<CR>

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"import coc config
source ~/.config/nvim/plug-config/coc.vim

lua << EOF
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

require('ufo').setup()
EOF
