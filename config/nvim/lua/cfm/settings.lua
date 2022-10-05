
vim.cmd([[
set completeopt=menuone,noinsert,noselect
set mouse=a
set splitright
set splitbelow
set expandtab
set tabstop=4
set shiftwidth=4
set number
"set signcolumn=yes
set diffopt+=vertical
set fillchars+=diff:╱
set hidden
set nobackup
set nowritebackup
set shortmess+=c

set hlsearch
set mousehide
set showcmd
set ruler
set cursorline

set noequalalways

set spelllang=en

set clipboard^=unnamed,unnamedplus

filetype plugin indent on

set background=dark
syntax enable

set path=.
set path+=,,

"set listchars=tab:>-,trail:-,extends:>,precedes:<
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣
set showbreak=↪

set termguicolors

function! SetEsriStyle()
  set list et sts=2 sw=2 nowrap tw=100 fo=cqro
  set cindent cino={:0,g0,c0,(0,(s,m1
  "set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://!,://:,://
  set comments=://!,://:,:///,://

  setlocal signcolumn=yes
  "inoremap <C-N> <C-X><C-O>
  "inoremap <C-M> <C-X><C-O>

  "let g:lsp_diagnostics_enabled = 1
endfunction

autocmd FileType cmake set nowrap et sts=2 sw=2 tw=100 fo=cqro nospell nocindent
autocmd FileType cpp   call SetEsriStyle()
autocmd FileType sh    set list et sts=2 sw=2 nowrap tw=0

]])

