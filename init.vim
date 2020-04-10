syntax on
filetype plugin indent on


colo default                                                           " Set the colorscheme to darkblue
set autoindent
set autoread                                                            " Auto-reload files changed on disk
set background=dark
set cindent                                                             " Smart, customizable indentation
set expandtab                                                           " Use spaces instead of tabs
set grepprg=git\ grep\ -n\ $*                                           " set grep to git grep
set ignorecase                                                          " Make searches case-insensitive...
set laststatus=0
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¬,precedes:«,extends:» " show whitespace as characters
set nocompatible
set nolist                                                                " make the whitspace characters actually show up
set number
set relativenumber
set scrolloff=7                                                         " Some lines around scroll for context
set shiftround                                                          " Always indent/outdent to the nearest tabstop
set shiftwidth=2                                                        " Indent/outdent by 2 columns
set showmode
set smartcase                                                           " ...unless they contain at least one capital letter
set smartindent
set smarttab
set softtabstop=2                                                       " Unify
set tabstop=2                                                           " Soft tab size (default)

let mapleader = " "

" - VIM PLUG
call plug#begin('~/.local/share/nvim/plugged')

Plug 'Shougo/vimproc.vim', {'do':'make'}
Plug 'airblade/vim-gitgutter'
Plug 'alx741/vim-hindent'
Plug 'alx741/vim-stylishask'
Plug 'sbdchd/neoformat'
Plug 'bitc/vim-hdevtools'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dan-t/vim-hsimport'
Plug 'eagletmt/ghcmod-vim'
Plug 'eagletmt/neco-ghc'
Plug 'ensime/ensime-vim', { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'
Plug 'fszymanski/deoplete-emoji'
Plug 'godlygeek/tabular'
Plug 'johnmendonca/nvim'
Plug 'kchmck/vim-coffee-script'
Plug 'mhinz/vim-grepper'
Plug 'ndmitchell/ghcid'
Plug 'neovimhaskell/haskell-vim'
Plug 'pbrisbin/vim-syntax-shakespeare'
Plug 'purescript-contrib/purescript-vim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-unimpaired'
Plug 'unblevable/quick-scope'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/1.x',
  \ 'for': [
    \ 'javascript',
    \ 'typescript',
    \ 'css',
    \ 'less',
    \ 'scss',
    \ 'json',
    \ 'graphql',
    \ 'markdown',
    \ 'vue',
    \ 'lua',
    \ 'php',
    \ 'python',
    \ 'ruby',
    \ 'html',
    \ 'swift' ] }
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

Plug 'Shougo/denite.nvim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:yats_host_keyword=1
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources={}
let g:deoplete#sources._=['buffer', 'member', 'tag', 'file', 'omni', 'ultisnips']
let g:deoplete#omni#input_patterns={}
let g:deoplete#omni#input_patterns.scala='[^. *\t]\.\w*'

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_haskell_checkers=[]

function Om4TS()
  if match(bufname('%'), '\.tsx\?$') > -1
    set omnifunc=TSOmniFunc
  else
    set omnifunc=
  endif
endfunction

autocmd BufEnter * call Om4TS()

" Initialize plugin system
call plug#end()

"Open NERDTree when nvim starts
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"Toggle NERDTree with Ctrl-N
map <C-n> :NERDTreeToggle<CR>

"Show hidden files in NERDTree
let NERDTreeShowHidden=1

"Use Grepper
nnoremap <leader>ga :Grepper -tool rg<cr>
nnoremap <leader>gb :Grepper -buffer -tool rg<cr>
nmap gs  <plug>(GrepperOperator)

"Hack for neovim and vim-tmux-navigator
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

"haskell-vim settings
let g:haskell_indent_if = 2
let g:haskell_indent_case = 2
let g:haskell_indent_let = 2
let g:haskell_indent_where = 2
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 2
let g:haskell_indent_in = 2
let g:haskell_indent_guard = 2
let g:haskell_indent_case_alternative = 2
let g:cabal_indent_section = 2

" Ctrl-{hjkl} for navigating out of terminal panes
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

au FileType haskell nmap <leader>mc :GhcModSplitFunCase<CR>
au FileType haskell nmap <leader>ms :GhcModSigCodegen<CR>

" Does not work for latest GHC, until hdevtools is updated
au FileType haskell nnoremap <silent> <leader>ims :HsimportSymbol<CR>
au FileType haskell nnoremap <silent> <leader>imm :HsimportModule<CR>

let g:hindent_on_save = 0
au FileType haskell nnoremap <silent> <leader>ph :Hindent<CR>

let g:stylishask_on_save = 0
au FileType haskell nnoremap <silent> <leader>ps :Stylishask<CR>

let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

" Supertab
let g:SuperTabDefaultCompletionType = '<c-x><c-o>'


" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0

" neco-ghc
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Tabular
nnoremap <leader>= :Tabularize /=<CR>
nnoremap <leader>- :Tabularize /-><CR>
nnoremap <leader>< :Tabularize /<-<CR>
nnoremap <leader>, :Tabularize /,<CR>
nnoremap <leader># :Tabularize /#-}<CR>

" fzf.vim
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>ft :Tags<CR>
nnoremap <leader>fa :Rg<CR>

" Replace all instances of word under the cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

autocmd BufWritePre * %s/\s\+$//e
