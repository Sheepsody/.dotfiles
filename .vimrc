set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugin manager
Plugin 'VundleVim/Vundle.vim'

" Basic plugins
Plugin 'preservim/nerdtree'
Plugin 'junegunn/fzf' " Install the_silver_searcher
Plugin 'junegunn/fzf.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'preservim/nerdcommenter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'sjl/gundo.vim'

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
Plugin 'SirVer/ultisnips'

" C++ configuration
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'rhysd/vim-clang-format'

" Rust configuration
Plugin 'rust-lang/rust.vim'


call vundle#end()            " required

colorscheme molokai 

let g:coc_global_extensions = [
			\ 'coc-dictionary',
			\ 'coc-tsserver',
			\ 'coc-eslint',
			\ 'coc-python',
			\ 'coc-clangd',
			\ ]

filetype plugin indent on    " required
syntax on

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

" Leader
let mapleader=","

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
let mapleader="\\"

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

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

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

" Format with nvim
nmap <leader>f  <Plug>(coc-format-selected)
vmap <leader>f  <Plug>(coc-format-selected)

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
let g:ale_completion_enabled = 1
