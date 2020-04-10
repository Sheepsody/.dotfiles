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

" Markdown syntax, matching and mapping
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" Dense analysis 
" Used for error checking, fixing and linting
Plugin 'dense-analysis/ale'

" Conquer of Completion
" Used for Autocompletion
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
let mapleader=","

let g:airline_powerline_fonts = 1

let g:rustfmt_autosave = 1

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

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'

" Some servers have issues with backups
set nobackup
set nowritebackup

" Better user experience
set updatetime=300

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Add conceraling
set conceallevel=2
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_strikethrough = 1

" Format with nvim
nmap <leader>f  <Plug>(coc-format-selected)
vmap <leader>f  <Plug>(coc-format-selected)

let g:ale_fixers = {
\  'javascript': ['eslint'],
\  'python': ['autopep8'],
\}
let g:ale_fix_on_save = 1
