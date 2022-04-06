set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')

" Basic plugins
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf' " Install the_silver_searcher
Plug 'junegunn/fzf.vim'
Plug 'kien/ctrlp.vim'
Plug 'preservim/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'sjl/gundo.vim'

" Markdown syntax, matching and mapping
Plug 'godlygeek/tabular'

" Colorscheme & syntax
Plug 'joshdick/onedark.vim'

call plug#end()            " required

filetype plugin indent on    " required
syntax on

colorscheme onedark

" Leader
let mapleader=" "

" Tab behaviour
set tabstop=4
set softtabstop=4
set expandtab

" Show relative line number while editing
set number relativenumber

" Highlight current line
set cursorline

" highlight matching [{()}]
set showmatch

" visual autocomplete for command menu
set wildmenu

" Search behaviour 
set incsearch           
set hlsearch            
nnoremap <leader><space> :nohlsearch<CR>

" Folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
nnoremap <space> za
set foldmethod=indent 

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Global clipboard
set clipboard=unnamed

let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'

"" Bindings to switch between tabs
map <C-j> :tabprevious<CR>
nmap <C-j> :tabprevious<CR>
imap <C-j> <Esc>:tabprevious<CR>i
map <C-k> :tabnext<CR>
nmap <C-k> :tabnext<CR>
imap <C-k> <Esc>:tabnext<CR>i

" Setting line number

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

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" Give more space for displaying messages.
set cmdheight=2


set conceallevel=2
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 2

