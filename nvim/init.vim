syntax on

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set vb
set number
set encoding=utf8
set nowritebackup
set noswapfile
set nobackup
set splitbelow
set splitright
set ignorecase
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'nanotech/jellybeans.vim'
call plug#end()

set background=dark
colorscheme jellybeans

let g:airline_powerline_fonts = 1
let g_airline_theme = 'jellybeans'

set statusline+=%{FugitiveStatusLine()}
:tnoremap <Esc> <C-\><C-n>

" hi Normal guibg=NONE ctermbg=NONE

