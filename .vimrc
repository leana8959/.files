"""""""""""
" Options "
"""""""""""
set invhlsearch
set incsearch

set number
set relativenumber
set cursorline

set tabstop=4
set expandtab
set shiftwidth=4

set invwrap
set linebreak
set breakindent

set invswapfile
set invbackup
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

nmap <Leader>pv :Explore<CR> "  Project View
nmap <Leader>nf :enew<CR>    "  New File
nmap <Leader>so :so %<CR>    "  Source buffer
cmap #capl \(.\{-}\)     "  helpers in regex
cmap #capm \(.*\)

nmap <Leader>+x :!chmod +x %<CR> "  Permission
nmap <Leader>-x :!chmod -x %<CR>

nmap <Leader>w :setlocal invwrap " linewrap
nmap Q <nop>
