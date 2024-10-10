" Set leader key
let mapleader = " "

" Set Default Clipboard to System
set clipboard=unnamedplus

" Turn on Line Numbers
set number

" Plugin manager setup using vim-plug
call plug#begin('~/.vim/plugged')

" Fzf.vim for fuzzy finding (alternative to Telescope)
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'

" YouCompleteMe for auto-completion (alternative to nvim-cmp)
" Plug 'ycm-core/YouCompleteMe'

" Vim-polyglot for language syntax highlighting (alternative to Treesitter)
Plug 'sheerun/vim-polyglot'

" Coc.nvim for LSP-like functionality (alternative to nvim-lspconfig)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Rainbow parentheses support (alternative to nvim-ts-rainbow)
Plug 'luochen1990/rainbow'

" Easy Commenting
Plug 'tpope/vim-commentary'

call plug#end()

" Configure Coc.nvim for Python LSP
autocmd BufNewFile,BufRead *.py setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
let g:coc_global_extensions = ['coc-pyright'] 

" Configure YouCompleteMe
" let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" Fzf.vim setup for fuzzy finding
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>

" Rainbow parentheses
let g:rainbow_active = 1

" Set autocomplete menu background 
highlight Pmenu ctermbg=black ctermfg=white guibg=#1c1c1c guifg=#ffffff
highlight PmenuSel ctermbg=gray ctermfg=black guibg=#444444 guifg=#ffffff

highlight CocFloating ctermbg=black ctermfg=white guibg=#1c1c1c guifg=#ffffff
highlight CocFloatingSel ctermbg=gray ctermfg=black guibg=#444444 guifg=#ffffff
highlight CocFloatingDiagnostics ctermbg=black ctermfg=white guibg=#1c1c1c guifg=#ffffff
highlight CocInlayHint ctermbg=black ctermfg=white guibg=#1c1c1c guifg=#ffffff

