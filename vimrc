
""" settings
set nocompatible
set hidden                " keep changes in buffers in memory even when not visible
set hlsearch              " highlight search term
set mousehide             " Hide the mouse when typing text
set showcmd               " show half entered commands
set ruler                 " show line and column number of cursor position
set guioptions-=T         " No toolbar
set guioptions-=l         " No scrollbar
set guioptions-=L         " No scrollbar
set guioptions-=r         " No scrollbar
set guioptions-=R         " No scrollbar
set guicursor=a:blinkon0  " Disable blinking cursor
set cursorline            " highlight cursor line
set number                " line numbers
set timeoutlen=1000       " timeout on mappings
set ttimeoutlen=10        " timeout on key codes. This eliminates the delay entering normal mode with ESC

set diffopt+=vertical
set clipboard^=unnamed

filetype plugin indent on

""" pathogen
execute pathogen#infect('bundle/{}', 'local/{}')


""" more settings

set background=dark
if has("gui_running")
  syntax on
  if has("win32")
    set guifont=Courier_New:h12:cANSI
  else
    set guifont=Monospace\ 14
  endif
else
  syntax enable
endif

let g:seoul256_background = 233
colorscheme seoul256

set path=.
set path+=,,

"set listchars=tab:>-,trail:-,extends:>,precedes:<
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣
set showbreak=↪

" listchar=trail is not as flexible, use the below to highlight trailing
" whitespace. Don't do it for readonly files
"highlight ExtraWhitespace ctermbg=darkblue guibg=darkblue
hi link ExtraWhitespace DiffAdd
match ExtraWhitespace /\s\+$/
augroup MyAutoCmd
  autocmd BufWinEnter * if &modifiable | match ExtraWhitespace /\s\+$/ | endif
  autocmd InsertEnter * if &modifiable | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
  autocmd InsertLeave * if &modifiable | match ExtraWhitespace /\s\+$/ | endif
  autocmd BufWinLeave * if &modifiable | call clearmatches() | endif
augroup END

set spelllang=en spellfile=~/dotfiles/vim/spellfile.latin1.add

" cursorline is weird in diff mode
if &diff
   set nocursorline
endif

" sane regex
"nnoremap / /\v
"vnoremap / /\v
"nnoremap ? ?\v
"vnoremap ? ?\v
"cnoremap s/ s/\v

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" commands

imap <C-l> <Esc>

noremap <Space> <PageDown>
"nmap <C-Tab>      <C-^>

" stop from hitting F1 by accident
map <F1> <Esc>

" turn off highlighted search
noremap <silent> <C-N> :silent noh<CR>

" Substitute(Replace)
nmap ,s :%s/<C-R><C-W>//gc<Left><Left><Left>
nmap ,S :%s/\<<C-R><C-W>\>//gc<Left><Left><Left>

" toggle highlight cursor column
nmap ,l :set cursorcolumn!<CR>

" build errors
function! LoadErrors()
  set errorfile=errors.err
  :cf
endfunction
command! Err call LoadErrors()

nmap ,e :NERDTreeFind<CR>
nmap ,a :AckFromSearch<CR>
nmap ,f :CtrlP<CR>
nmap ,b :CtrlPBuffer<CR>
nmap ,t :CtrlPTag<CR>
nmap ,c :CtrlPBufTag<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" modules

" NERDTree
let NERDTreeQuitOnOpen=1
let NERDTreeWinPos='right'
let NERDTreeWinSize=45
hi def link NERDTreeRO Comment


" :A
let g:alternateNoDefaultAlternate=1
let g:alternateSearchPath = 'reg:|/src|/inc|,reg:|/inc|/src|'
"let g:alternateSearchPath .= ',reg:|/lib/\([^/]*\)/src|/include/\1|'
"let g:alternateSearchPath .= ',reg:|/include/\([^/]*\)|/lib/\1/src|'

if has("win32")
  " stupid windows
  let g:alternateSearchPath .= ',reg:|\\lib\\\([^/]*\)\\src|\\include\\\1|'
  let g:alternateSearchPath .= ',reg:|\\include\\\([^/]*\)|\\lib\\\1\\src|'
else
  let g:alternateSearchPath .= ',reg:|/libs/\([^/]*\)/src|/include/\1|'
  let g:alternateSearchPath .= ',reg:|/include/\([^/]*\)|/libs/\1/src|'
endif

let g:alternateExtensions_h   = "c,cpp,cxx,tpp,txx,cc,CC"
let g:alternateExtensions_cpp = "hpp,h"
let g:alternateExtensions_hpp = "cpp"
let g:alternateExtensions_tpp = "hpp"
let g:alternateExtensions_txx = "hxx,h"


" perforce
" by default have the perforce crap disabled. One can enable it in .vimrc-local with
" unlet! loaded_perforce
let loaded_perforce=1

" lid
let LID_Jump_To_Match = 0

" vimwiki
let g:vimwiki_list = [{'path': '~/notes/w/', 'syntax': 'markdown', 'ext': '.md'},
                    \ {'path': '~/notes/p/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_conceallevel = 0


""vim-airline
set laststatus=2
let g:airline_left_sep  = ''
let g:airline_right_sep = ''
let g:airline#extensions#whitespace#enabled = 0

" vim-bufsurf
nmap <silent> <A-Left> :BufSurfBack<CR>
nmap <silent> <A-Right> :BufSurfForward<CR>

" vim-sneak
"replace 'f' with 1-char Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
"replace 't' with 1-char Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

""" Code style
function SetDwsStyle()
	autocmd FileType cpp set list et sts=4 sw=4 nowrap tw=80 fo=cqro cindent cino={:0,g0,c0,(0,(s,m1 comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://!,://:,://
endfunction

function SetWorkmateStyle()
	autocmd FileType cpp set list noet ts=4 sts=4 sw=4 nowrap tw=80 fo=cqro cindent cino={:0,g0,c0,(0,(s,m1 comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://!,://
endfunction

function SetLlvmStyle()
	autocmd FileType cpp set list et sts=2 sw=2 nowrap tw=80 fo=cqro cindent cino={:0,g0,c0,(0,(s,m1 comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://!,://
endfunction

command! Sdws  call SetDwsStyle()
command! Swm   call SetWorkmateStyle()
command! Sllvm call SetLlvmStyle()

"call SetLlvmStyle()
call SetDwsStyle()

""" Custom commands

autocmd BufEnter *.miki setfiletype miki
"autocmd BufEnter *.mdwn setfiletype ikiwiki
autocmd BufEnter Jamfile,Jamroot set ft=conf nocindent nowrap
autocmd BufEnter *.cpp,*.cxx,*.txx,*.h,*.hpp,*.hxx,*.cl,*.cpp#\d\+,*.h#\d\+ set ft=cpp
"autocmd BufEnter *.d set ft=d
autocmd BufEnter *.dox set syntax=cpp.doxygen tw=80 nocindent lbr fo=tqln
autocmd BufEnter *SSDD.txt set syntax=cpp.doxygen spell et sts=2 tw=80 nocindent ai lbr fo=tqln
autocmd BufEnter *.tex set ft=tex
autocmd BufEnter SConstruct,SConscript set ft=python
autocmd BufEnter *.m set ft=octave
autocmd BufEnter *.glsl set ft=cpp
autocmd BufEnter *.xdef set ft=cpp
autocmd BufEnter .bash_* set ft=sh
autocmd BufEnter *CMakeLists.txt set ft=cmake
autocmd BufEnter *.pro set ft=make
"autocmd BufEnter *.txt setfiletype miki

autocmd FileType sh set list et sts=4 sw=4 nowrap tw=80

autocmd FileType tex set spell et sts=2 sw=2 tw=80 nocindent lbr fo=tqln grepprg=grep\ -nH\ $*

autocmd FileType perl set list et sts=4 sw=4 nowrap tw=0

" frank cpp style
"autocmd FileType cpp set list et sts=2 sw=2 nowrap tw=80 fo=cqro cindent cino={1s,f1s,:0,l1,g0,c0,(0,(s,m1 comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://!,://

" alternate style
"autocmd FileType cpp set list nowrap noet sts=3 sw=3 tw=80 fo=cqro cindent cino={1s,f1s,:0,l1,g0,c0,(0,(s,m1 comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://!,://

autocmd FileType d set list et sts=2 sw=2 nowrap tw=80 fo=cqro cindent cino={:0,g0,c0,(0,(s,m1 comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://!,://

autocmd FileType mail set spell et sts=2 tw=72 ai lbr fo=tln
autocmd FileType html set spell nocindent autoindent lbr et sts=2 sw=2 list

autocmd FileType bzr       set spell et sts=2 tw=58 nocindent lbr fo=tqln
autocmd FileType gitcommit set spell et sts=2 tw=72 nocindent lbr fo=tqln

autocmd FileType help :hi Ignore guifg=yellow

autocmd FileType make set noet list nocindent nowrap
autocmd FileType cmake set nowrap et sts=4 sw=4 tw=80 fo=cqro nospell nocindent
autocmd FileType vimwiki call SetWikiOptions()

"autocmd Syntax c,cpp,vim,xml,html,xhtml,perl setlocal foldmethod=syntax
"autocmd BufReadPost *.cpp,*.cxx,*.txx,*.h,*.hpp,*.hxx,*.cl :normal zR

function SetWikiOptions()
	set spell list et ts=4 sts=4 sw=4 tw=72 lbr ai
	syntax region codeBlock start='^    \|\t' end='$' oneline keepend
	hi def link codeBlock String
	set formatoptions+=tnro
	set formatoptions-=cq
	set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^[-*+]\\s\\+
endfunction


"autocmd FileType nerdtree set ignorecase incsearch

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Local customization
try
  source ~/.vimrc-local
catch
endtry

