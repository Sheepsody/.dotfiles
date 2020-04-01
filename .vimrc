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

Plugin 'tomasr/molokai'

Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'rhysd/vim-clang-format'

Plugin 'rust-lang/rust.vim'

Plugin 'sheerun/vim-polyglot'

call vundle#end()            " required

colorscheme molokai

filetype plugin indent on    " required
syntax on

let g:airline_powerline_fonts = 1

" If RUST_SRC_PATH or RACER (on $PATH) not defined
" let g:racer_cmd="/Users/danirod/.cargo/bin/racer"
" let $RUST_SRC_PATH="/home/VVialard/Developer/rust-master/src"

let g:ycm_rust_src_path="/home/VVialard/Developer/rust-master/src/"

"" Bindings to switch between tabs
map <C-j> :tabprevious<CR>
nmap <C-j> :tabprevious<CR>
imap <C-j> <Esc>:tabprevious<CR>i
map <C-k> :tabnext<CR>
nmap <C-k> :tabnext<CR>
imap <C-k> <Esc>:tabnext<CR>i

" Setting line number
:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" Some servers have issues with backups
set nobackup
set nowritebackup

" Better user experience
set updatetime=300

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

