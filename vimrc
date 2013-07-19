
""" settings
set nocompatible
set hidden                " keep changes in buffers in memory even when not visible
set hlsearch              " highlight search term
set cursorline            " highlight cursor line
set mousehide             " Hide the mouse when typing text
set showcmd               " show half entered commands
set ruler                 " show line and column number of cursor position
set guioptions-=T         " No toolbar
set guioptions-=l         " No scrollbar
set guioptions-=L         " No scrollbar
set guioptions-=r         " No scrollbar
set guioptions-=R         " No scrollbar
set guicursor=a:blinkon0  " Disable blinking cursor

filetype plugin indent on


""" neobundle
if has('vim_starting')
  set runtimepath+=~/dotfiles/vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/dotfiles/vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'make -f make_mingw32.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'unix' : 'make -f make_unix.mak',
    \    },
    \ }

NeoBundle 'vim-scripts/a.vim'
NeoBundle 'tpope/vim-fugitive'

" Color
NeoBundle 'noahfrederick/vim-noctu'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'ujihisa/unite-colorscheme'

" Unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite-help'
NeoBundle 'Shougo/unite-session'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'mileszs/ack.vim'

" File browsing
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/vimfiler'

" other
NeoBundle 'vim-scripts/genutils'
"NeoBundle 'vim-scripts/perforce'
NeoBundle 'pydave/vim-perforce'
NeoBundle 'vim-scripts/bufexplorer.zip'

" Local plugins
execute 'NeoBundleLocal' '~/dotfiles/vim/local'

NeoBundleCheck


""" more settings

if has("gui_running")
  set guifont=Monospace\ 14
  syntax on
  set background=dark
  colorscheme frank
  "colorscheme jellybeans
else
  syntax enable
  set background=dark
  "colorscheme solarized
  colorscheme noctu
endif

set path=.
set path+=,,

set listchars=tab:>-,trail:-,extends:>,precedes:<
"set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣
"set showbreak=↪

" listchar=trail is not as flexible, use the below to highlight trailing
" whitespace. Don't do it for unite windows or readonly files
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
augroup MyAutoCmd
  autocmd BufWinEnter * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+$/ | endif
  autocmd InsertEnter * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
  autocmd InsertLeave * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+$/ | endif
  autocmd BufWinLeave * if &modifiable && &ft!='unite' | call clearmatches() | endif
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

noremap <Space> <PageDown>
nmap <C-Tab>      <C-^>

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" modules

" NERDTree
let NERDTreeQuitOnOpen=1
let NERDTreeWinPos='right'
let NERDTreeWinSize=45
nmap ,e :NERDTreeFind<CR>
hi def link NERDTreeRO Comment

" Unite
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])

nnoremap ,b :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
nnoremap ,r :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap ,f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap ,a :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap ,o :<C-u>Unite -no-split -buffer-name=outline outline<cr>
nnoremap ,y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

" VimFiler
" TODO Look into Vimfiler more
" Example at: https://github.com/hrsh7th/dotfiles/blob/master/vim/.vimrc

nnoremap <expr>,,e g:my_open_explorer_command()
"function! g:my_open_explorer_command()
"  return printf(":\<C-u>VimFilerBufferDir -buffer-name=%s -simple -split -auto-cd -toggle -no-quit -winwidth=%s\<CR>",
"        \ g:my_vimfiler_explorer_name,
"        \ g:my_vimfiler_winwidth)
"endfunction

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
" let g:vimfiler_file_icon = ' '
let g:vimfiler_marked_file_icon = '✓'
" let g:vimfiler_readonly_file_icon = ' '
let g:my_vimfiler_explorer_name = 'explorer'
let g:my_vimfiler_winwidth = 45
let g:vimfiler_safe_mode_by_default = 0
" let g:vimfiler_directory_display_top = 1

autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
function! s:vimfiler_settings()
  nmap <buffer><expr><CR> vimfiler#smart_cursor_map("\<PLUG>(vimfiler_expand_tree)", "e")
endfunction


" :A
let g:alternateNoDefaultAlternate=1
let g:alternateSearchPath = 'reg:|/src|/inc|,reg:|/inc|/src|'
"let g:alternateSearchPath .= ',reg:|/lib/\([^/]*\)/src|/include/\1|'
"let g:alternateSearchPath .= ',reg:|/include/\([^/]*\)|/lib/\1/src|'
let g:alternateSearchPath .= ',reg:|/libs/\([^/]*\)/src|/include/\1|'
let g:alternateSearchPath .= ',reg:|/include/\([^/]*\)|/libs/\1/src|'

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Custom commands

autocmd BufEnter *.miki setfiletype miki
autocmd BufEnter *.mdwn setfiletype ikiwiki
autocmd BufEnter Jamfile,Jamroot set ft=conf nocindent nowrap
autocmd BufEnter *.cpp,*.cxx,*.txx,*.h,*.hpp,*.hxx,*.cl set ft=cpp
"autocmd BufEnter *.d set ft=d
autocmd BufEnter *.dox set syntax=cpp.doxygen tw=80 nocindent lbr fo=tqln
autocmd BufEnter *SSDD.txt set syntax=cpp.doxygen spell et sts=2 tw=80 nocindent ai lbr fo=tqln
autocmd BufEnter *.html,*.htm set spell nocindent autoindent lbr
autocmd BufEnter *.tex set ft=tex
autocmd BufEnter SConstruct,SConscript set ft=python
autocmd BufEnter *.m set ft=octave
autocmd BufEnter *.glsl set ft=cpp
autocmd BufEnter *.xdef set ft=cpp
autocmd BufEnter .bash_* set ft=sh
autocmd BufEnter *CMakeLists.txt set ft=cmake
autocmd BufEnter *.pro set ft=make
"autocmd BufEnter *.txt setfiletype miki

autocmd FileType tex set spell et sts=2 sw=2 tw=80 nocindent lbr fo=tqln grepprg=grep\ -nH\ $*

" frank cpp style
"autocmd FileType cpp set list et sts=2 sw=2 nowrap tw=80 fo=cqro cindent cino={1s,f1s,:0,l1,g0,c0,(0,(s,m1 comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://!,://

" sjm cpp style
autocmd FileType cpp set list et sts=4 sw=4 nowrap tw=80 fo=cqro cindent cino={:0,g0,c0,(0,(s,m1 comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://!,://
autocmd FileType perl set list et sts=4 sw=4 nowrap tw=0

" alternate style
"autocmd FileType cpp set list nowrap noet sts=3 sw=3 tw=80 fo=cqro cindent cino={1s,f1s,:0,l1,g0,c0,(0,(s,m1 comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://!,://

autocmd FileType d set list et sts=2 sw=2 nowrap tw=80 fo=cqro cindent cino={1s,f1s,:0,l1,g0,c0,(0,(s,m1 comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://!,://

autocmd FileType mail set spell et sts=2 tw=72 ai lbr fo=tln

autocmd FileType bzr       set spell et sts=2 tw=58 nocindent lbr fo=tqln
autocmd FileType gitcommit set spell et sts=2 tw=72 nocindent lbr fo=tqln

autocmd FileType help :hi Ignore guifg=yellow

autocmd FileType make set noet list nocindent nowrap
autocmd FileType cmake set nowrap et sts=2 sw=2 tw=80 fo=cqro nospell nocindent

"autocmd FileType nerdtree set ignorecase incsearch

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Local customization
try
  source ~/.vimrc-local
catch
endtry

