set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugin manager
Plugin 'VundleVim/Vundle.vim'

" Basic plugins
Plugin 'preservim/nerdtree'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'preservim/nerdcommenter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'

" Dense analysis
Plugin 'dense-analysis/ale'

" Intellisence
Plugin 'neoclide/coc.nvim'

" Colorscheme & syntax
Plugin 'tomasr/molokai'
Plugin 'sheerun/vim-polyglot'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" C++ configuration
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'rhysd/vim-clang-format'

" Rust configuration
Plugin 'rust-lang/rust.vim'

call vundle#end()            " required

colorscheme molokai

filetype plugin indent on    " required
syntax on

" Global clipboard
set clipboard=unnamed

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
