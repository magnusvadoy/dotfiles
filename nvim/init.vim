" Misc
set nocompatible            " disable compatibility to old-time vi
set clipboard=unnamedplus   " use system clipboard
set showmatch               " jumps to matching bracket
set cursorline              " highlight current cursorline

" Search
set ignorecase              " ignore case in search patterns 
set hlsearch                " highlights all matches of previous search pattern 
set incsearch               " highligts matches as you type

" Line Numbers
set number                  " add line numbers
set relativenumber          " show line numbers starting from the current one

" Tabs
set tabstop=2               " number of columns occupied by a tab 
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set shiftwidth=2            " width for autoindents
set expandtab               " converts tabs to white space
set autoindent              " indent a new line the same amount as the line just typed

" Mouse
set mouse=a                 " enable mouse mode for all modes
set ttyfast                 " Speed up scrolling in Vim

" Plugins
call plug#begin('~/.config/nvim/plugged')

" File Control / Navigating
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Theming
Plug 'ericbn/vim-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Colors 
if (has("termguicolors"))
 set termguicolors
endif

syntax enable
set background=dark
colorscheme solarized
let g:airline_theme='base16_solarized_dark'
let g:airline#extensions#tabline#enabled = 1

" Mappings
let mapleader = ","

" Git blame
" map <leader>g :Gblame<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Easy access to the shell
map <leader><leader> :!

" Include lua config (for mappings, telescope)
lua require('config')
