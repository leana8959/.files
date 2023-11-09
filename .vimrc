""""""""""""
" vim-plug "
""""""""""""
call plug#begin()

" Colorscheme
Plug 'owickstrom/vim-colors-paramount'

" Utils
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'mbbill/undotree'
Plug 'godlygeek/tabular'

call plug#end()

"""""""""""
" Options "
"""""""""""
set belloff=all

set hlsearch
set incsearch

set number
set relativenumber
set cursorline

set tabstop=4
set shiftwidth=4
set noexpandtab

set nowrap
set linebreak
set breakindent

set noswapfile
set nobackup
set undofile

set termguicolors
syntax on

set ignorecase
set smartcase
set autoindent
set smartindent

set scrolloff=3

set colorcolumn=80

"""""""""""
" Keymaps "
"""""""""""
let mapleader = " "

vmap J :m '>+1<CR>gv=gv
vmap K :m '<-2<CR>gv=gv

" Centered motions
nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz
nmap n nzzzv
nmap N Nzzzv
nmap J mzJ`z

" Better clipboard
nmap <Leader>d "_d
nmap <Leader>c "_dc
nmap <Leader>p "_dP
nmap <Leader>y "+y

xmap <Leader>d "_d
xmap <Leader>c "_dc
xmap <Leader>p "_dP
xmap <Leader>y "+y

vmap <Leader>d "_d
vmap <Leader>c "_dc
vmap <Leader>p "_dP
vmap <Leader>y "+y

" Linewrap jk
nmap j gj
nmap k gk
nmap <Down> g<Down>
nmap <Up> g<Up>

nmap <Leader>pv :Explore<CR> " Project View
nmap <Leader>nf :enew<CR>    " New File
nmap <Leader>so :so %<CR>    " Source buffer
cmap #capl \(.\{-}\)         " helpers in regex
cmap #capm \(.*\)

nmap <Leader>+x :!chmod +x %<CR> " Permission
nmap <Leader>-x :!chmod -x %<CR>

nmap <Leader>w :setlocal invwrap<CR> " linewrap
nmap Q <nop>

"""""""""""""""""""
" Plugin mappings "
"""""""""""""""""""

" Fugitive
nmap <leader><space> :Git<CR>5<Down>
autocmd FileType fugitive nmap <buffer> <leader><space> :q<CR>
nmap <leader>gb :Git blame<CR>
autocmd FileType fugitiveblame nmap <buffer> <leader>gb :q<CR>

" Undotree
nmap <leader>u :UndotreeToggle<CR>:UndotreeFocus<CR>
autocmd FileType undotree nmap <buffer> <leader>u :q<CR>

" Tabular
nmap <leader>ta Tabularize /=<CR>
nmap <leader>tc Tabularize /:<CR>
nmap <leader>tC Tabularize trailing_c_comments<CR>

"""""""""""""""
" Colorscheme "
"""""""""""""""
colorscheme paramount
