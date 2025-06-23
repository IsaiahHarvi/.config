let mapleader = " "

set clipboard=unnamedplus

set number

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

autocmd BufNewFile,BufRead *.py setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
let g:coc_global_extensions = ['coc-pyright']

let g:rainbow_active = 1

