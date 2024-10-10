let mapleader = " "

set clipboard=unnamedplus

set number

" using vim-plug
call plug#begin('~/.vim/plugged')

" alternative to Telescope
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'

" alternative to nvim-cmp
" Plug 'ycm-core/YouCompleteMe'

" alternative to Treesitter
Plug 'sheerun/vim-polyglot'

" alternative to nvim-lspconfig
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" alternative to nvim-ts-rainbow
Plug 'luochen1990/rainbow'

Plug 'tpope/vim-commentary'

call plug#end()

autocmd BufNewFile,BufRead *.py setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
let g:coc_global_extensions = ['coc-pyright'] 

" let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>

let g:rainbow_active = 1

" better coloring for wezterm color-theme
highlight Pmenu ctermbg=black ctermfg=white guibg=#1c1c1c guifg=#ffffff
highlight PmenuSel ctermbg=gray ctermfg=black guibg=#444444 guifg=#ffffff
highlight CocFloating ctermbg=black ctermfg=white guibg=#1c1c1c guifg=#ffffff
highlight CocFloatingSel ctermbg=gray ctermfg=black guibg=#444444 guifg=#ffffff
highlight CocFloatingDiagnostics ctermbg=black ctermfg=white guibg=#1c1c1c guifg=#ffffff
highlight CocInlayHint ctermbg=black ctermfg=white guibg=#1c1c1c guifg=#ffffff

