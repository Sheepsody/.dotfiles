set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'dense-analysis/ale'
Plugin 'preservim/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'neoclide/coc.nvim'

Plugin 'vim-airline/vim-airline'

Plugin 'sickill/vim-monokai'

Plugin 'octol/vim-cpp-enhanced-highlight'

Plugin 'rust-lang/rust.vim'

Plugin 'sheerun/vim-polyglot'

call vundle#end()            " required

call coc#util#install()

colorscheme monokai

filetype plugin indent on    " required
syntax on

let g:airline_powerline_fonts = 1

" If RUST_SRC_PATH or RACER (on $PATH) not defined
" let g:racer_cmd="/Users/danirod/.cargo/bin/racer"
" let $RUST_SRC_PATH="/home/VVialard/Developer/rust-master/src"

let g:ycm_rust_src_path="/home/VVialard/Developer/rust-master/src/"

"" Bindings to switch between tabs
map <C-k> :tabprevious<CR>
nmap <C-k> :tabprevious<CR>
imap <C-k> <Esc>:tabprevious<CR>i
map <C-j> :tabnext<CR>
nmap <C-j> :tabnext<CR>
imap <C-j> <Esc>:tabnext<CR>i

" Setting line number
:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
