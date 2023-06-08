"line numbers
set number

"plugins
call plug#begin('~/AppData/Local/nvim/plugged')

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

"code jumper
Plug 'davidhalter/jedi-vim'

"multiple cursors
Plug 'terryma/vim-multiple-cursors'

"fold them functions
Plug 'tmhedberg/SimpylFold'

"colortheme
Plug 'joshdick/onedark.vim'

"closing buffers
Plug 'moll/vim-bbye'

call plug#end()

"setting colorscheme
syntax on
colorscheme onedark

"start with initialized NerdTree
autocmd vimenter * NERDTree D:\Paul

"auto close NERDTree if last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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
        execute '!py -3.10 "%:p" ' . a:fargs
    elseif a:ftype == 'cpp'
	    echo expand("%:p:h") . "/Makefile"
        if filereadable(getcwd() . "/Makefile")
            execute "!make"
            execute "!cd bin && app.exe"
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

"code jumper
let g:jedi#completions_enabled = 0
let g:jedi#use_splits_not_buffer = "right"

let jedi#force_py_version=3.10

let g:clang_library_path='~\\AppData\\Local\\coc\\extensions\\coc-clangd-data\\install\\15.0.6\\clangd_15.0.6\\bin'
let g:coc_clangd_cmd = 'clangd'
let $NVIM_COC_LOG_LEVEL = 'debug'

filetype plugin indent on

autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"import coc config
source ~/AppData/Local/nvim/plug-config/coc.vim
