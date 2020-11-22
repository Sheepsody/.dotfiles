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
Plug 'plasticboy/vim-markdown'

" Conquer of Completion
" Used for Autocompletion
Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }

" Colorscheme & syntax
Plug 'tomasr/molokai'
Plug 'sheerun/vim-polyglot'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" C++ configuration
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rhysd/vim-clang-format'

" Rust configuration
Plug 'rust-lang/rust.vim'

call plug#end()            " required

colorscheme molokai 

filetype plugin indent on    " required
syntax on

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

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

let g:coc_global_extensions = [
			\ 'coc-dictionary',
			\ 'coc-tsserver',
			\ 'coc-eslint',
			\ 'coc-python',
			\ 'coc-clangd',
			\ 'coc-rls',
			\ 'coc-texlab',
			\ ]

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

set conceallevel=2
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 2

let g:ale_linters = { 
			\ 'rust' : ['rustc', 'rls'],
			\ 'python': ['pylint'],
\}

let g:ale_fixers = {
\  'javascript': ['eslint'],
\  'python': ['autopep8'],
\  'rust': ['rustfmt']
\}

let g:ale_fix_on_save = 1
let g:ale_python_pylint_executable = 'python3'
let g:ale_python_pylint_use_global = 1
let g:ale_completion_enabled = 0
