
" use space as leader key
nnoremap <space> <nop>
let mapleader = "\<space>"

let s:vimrc       = '/d/home/cfm/.config/nvim/init.vim'
let s:clangformat = '/d/opt/devtoolset-7/share/clang/clang-format.py'
"let s:clangformat = '/opt/clang/3.9/share/clang/clang-format.py'
"let s:clangformat = '/d/local/share/clang/clang-format.py'

""" settings
set hidden                " keep changes in buffers in memory even when not visible
set hlsearch              " highlight search term
"set ignorecase smartcase  " ignore case of normal letters when pattern is all lowercase
set mousehide             " Hide the mouse when typing text
set showcmd               " show half entered commands
set ruler                 " show line and column number of cursor position
set cursorline            " highlight cursor line
set number                " line numbers
set timeoutlen=1000     " timeout on mappings
set ttimeoutlen=10      " timeout on key codes. This eliminates the delay entering normal mode with ESC

set diffopt+=vertical
set clipboard^=unnamed,unnamedplus

filetype plugin indent on

set mouse=a

set background=dark
syntax enable

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

set spelllang=en
"set spellfile=~/dotfiles/vim/spellfile.latin1.add

" cursorline is weird in diff mode
if &diff
   set nocursorline
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" modules

call plug#begin('~/.config/vimplug')

Plug 'junegunn/vim-plug'

Plug 'junegunn/seoul256.vim'
Plug 'bling/vim-airline'
Plug 'vim-scripts/a.vim'
"Plug 'vim-scripts/bufexplorer.zip'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeFind' }
Plug 'MattesGroeger/vim-bookmarks'
Plug 'vimwiki/vimwiki', { 'branch': 'master' }
Plug 'mileszs/ack.vim'
Plug 'qpkorr/vim-bufkill'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'JuliaLang/julia-vim'
Plug 'peterhoeg/vim-qml'


"Plug 'critiqjo/lldb.nvim'
"Plug '/ws/fmiller/local/src/llvm/upstream/tools/lldb/utils/vim-lldb'
"Plug 'gilligan/vim-lldb'

"Plug 'huawenyu/neogdb.vim'
Plug 'sakhnik/nvim-gdb'

"Plug 'pydave/vim-perforce' | Plug 'vim-scripts/genutils'
Plug 'ngemily/vim-vp4'

" Add plugins to &runtimepath
call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" modules settings

" color scheme
let g:seoul256_background = 233
colorscheme seoul256

"vim-airline
set laststatus=2
let g:airline_left_sep  = ''
let g:airline_right_sep = ''
let g:airline#extensions#whitespace#enabled = 0


" NERDTree
let NERDTreeQuitOnOpen=1
let NERDTreeWinPos='right'
let NERDTreeWinSize=45
hi def link NERDTreeRO Comment

" vim-bookmarks
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1


" :A

" velocity
let g:alternateNoDefaultAlternate=1
let g:alternateSearchPath = 'reg:|/src|/inc|,reg:|/inc|/src|'

" segmentation
let g:alternateSearchPath .= ',reg:|/src/\([^/]*\)/private|/src/\1/include/\1|'
let g:alternateSearchPath .= ',reg:|/include/\([^/]*\)|/private|'

" sjmcommon
let g:alternateSearchPath .= ',reg:|/src/\([^/]*\)/private|/include/\1|'
let g:alternateSearchPath .= ',reg:|/include/\([^/]*\)|/src/\1/private|'

"if has("win32")
"  " stupid windows
"  let g:alternateSearchPath .= ',reg:|\\lib\\\([^/]*\)\\src|\\include\\\1|'
"  let g:alternateSearchPath .= ',reg:|\\include\\\([^/]*\)|\\lib\\\1\\src|'
"else
"  let g:alternateSearchPath .= ',reg:|/libs/\([^/]*\)/src|/include/\1|'
"  let g:alternateSearchPath .= ',reg:|/include/\([^/]*\)|/libs/\1/src|'
"endif

let g:alternateExtensions_h   = "c,cpp,cxx,tpp,txx,cc,CC"
let g:alternateExtensions_cpp = "hpp,h"
let g:alternateExtensions_hpp = "cpp"
let g:alternateExtensions_tpp = "hpp"
let g:alternateExtensions_txx = "hxx,h"


" perforce
" by default have the perforce crap disabled. One can enable it in .vimrc-local with
" unlet! loaded_perforce
let loaded_perforce=1


" vimwiki
"let g:vimwiki_list = [{'path': '~/notes/w/', 'syntax': 'markdown', 'ext': '.md'},
"                    \ {'path': '~/notes/p/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_list = [{'path': '~/notes/', 'syntax': 'markdown', 'ext': '.md'}]
"let g:vimwiki_hl_headers = 1
let g:vimwiki_conceallevel = 0




""" Code style
"function SetDwsStyle()
"	autocmd FileType cpp set list et sts=4 sw=4 nowrap tw=80 fo=cqro cindent cino={:0,g0,c0,(0,(s,m1 comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://!,://:,://
"endfunction
"
"function SetWorkmateStyle()
"	autocmd FileType cpp set list noet ts=4 sts=4 sw=4 nowrap tw=80 fo=cqro cindent cino={:0,g0,c0,(0,(s,m1 comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://!,://
"endfunction
"
"function SetLlvmStyle()
"	autocmd FileType cpp set list et sts=2 sw=2 nowrap tw=80 fo=cqro cindent cino={:0,g0,c0,(0,(s,m1 comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://!,://
"endfunction
"
"command! Sdws  call SetDwsStyle()
"command! Swm   call SetWorkmateStyle()
"command! Sllvm call SetLlvmStyle()
"
""call SetLlvmStyle()
"call SetDwsStyle()

function! SetSjmStyle()
  set list et sts=4 sw=4 nowrap tw=80 fo=cqro
  set cindent cino={:0,g0,c0,(0,(s,m1
  "set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://!,://:,://
  set comments=://!,://:,:///,://
endfunction

autocmd FileType cpp call SetSjmStyle()

""" Custom commands

autocmd BufEnter *.cpp,*.cxx,*.txx,*.h,*.hpp,*.hxx,*.cl,*.cpp#\d\+,*.h#\d\+ set ft=cpp
autocmd BufEnter *.qml set ft=qml
autocmd BufEnter *.dox set syntax=cpp.doxygen tw=80 nocindent lbr fo=tqln
autocmd BufEnter *SSDD.txt set syntax=cpp.doxygen spell et sts=2 tw=80 nocindent ai lbr fo=tqln
autocmd BufEnter *.tex set ft=tex
autocmd BufEnter *.m set ft=octave
autocmd BufEnter *.glsl set ft=cpp
autocmd BufEnter *.xdef set ft=cpp
autocmd BufEnter .bash_* set ft=sh
autocmd BufEnter *CMakeLists.txt set ft=cmake
autocmd BufEnter *.pro set ft=make

autocmd FileType tex   set spell et sts=4 sw=4 tw=80 nocindent lbr fo=tqln grepprg=grep\ -nH\ $*
autocmd FileType sh    set list et sts=4 sw=4 nowrap tw=0
autocmd FileType perl  set list et sts=4 sw=4 nowrap tw=0
autocmd FileType julia set list et sts=4 sw=4 nowrap

autocmd FileType mail set spell et sts=2 tw=72 ai lbr fo=tln
autocmd FileType html set spell nocindent autoindent lbr et sts=2 sw=2 list

autocmd FileType gitcommit set spell et sts=2 tw=72 nocindent lbr fo=tqln

autocmd FileType help :hi Ignore guifg=yellow

autocmd FileType make set noet list nocindent nowrap
autocmd FileType cmake set nowrap et sts=4 sw=4 tw=80 fo=cqro nospell nocindent
autocmd FileType vimwiki call SetWikiOptions()

autocmd FileType qml set list et sts=4 sw=4 nowrap tw=90 fo=cqro

"autocmd Syntax c,cpp,vim,xml,html,xhtml,perl setlocal foldmethod=syntax
"autocmd BufReadPost *.cpp,*.cxx,*.txx,*.h,*.hpp,*.hxx,*.cl :normal zR

function! SetWikiOptions()
	set spell list et ts=4 sts=4 sw=4 tw=72 lbr ai
	syntax region codeBlock start='^    \|\t' end='$' oneline keepend
	hi def link codeBlock String
	set formatoptions+=tnro
	set formatoptions-=cq
	set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^[-*+]\\s\\+
	
	"hi def link VimwikiHeaderChar String
	"hi def link VimwikiCodeChar String
endfunction

"autocmd FileType nerdtree set ignorecase incsearch


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Make v<motions>Y act like an incremental v<motion>y
vnoremap <silent>       Y  <ESC>:silent let @y = @"<CR>gv"Yy:silent let @" = @y<CR>

" Make Y<motion> act like an incremental y<motion>
nnoremap <silent><expr> Y  Incremental_Y()

function! Incremental_Y ()
    " After the Y operator, read in the associated motion
    let motion = nr2char(getchar())

    " If it's a (slowly typed) YY, do the optimized version instead (see below)
    if motion == 'Y'
        call Incremental_YY()
        return

    " If it's a text object, read in the associated motion
    elseif motion =~ '[ia]'
        let motion .= nr2char(getchar())
    endif

    " If it's a search, read in the associated pattern
    elseif motion =~ '[/?]'
        let motion .= input(motion) . "\<CR>"
    endif

    " Copy the current contents of the default register into the 'y register
    let @y = @"

    " Return a command sequence that yanks into the 'Y register,
    " then assigns that cumulative yank back to the default register
    return '"Yy' . motion . ':let @" = @y' . "\<CR>"
endfunction


" Make YY act like an incremental yy
nnoremap <silent>  YY  :call Incremental_YY()<CR>

function! Incremental_YY () range
    " Grab all specified lines and append them to the default register
    let @" .= join(getline(a:firstline, a:lastline), "\n") . "\n"
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" stolen from https://github.com/kassio/vimfiles

function! Preserve(command)
  setlocal lazyredraw
  let l:search=@/

  let last_view = winsaveview()
  execute a:command
  call winrestview(last_view)

  let @/=l:search
  redraw
  setlocal nolazyredraw
endfunction

function! TextHighlight(text)
  let @/="\\<" . a:text . "\\>"
  call feedkeys(":let v:hlsearch=1\<CR>", "n")
  call feedkeys(":call Preserve('%s//&/gn')\<CR>", "n")
endfunction

nnoremap <silent> ! :call TextHighlight(expand('<cword>'))<CR>

" have * respect smartcase
"function! TextSearch()
"    call TextHighlight(expand('<cword>'))
"    call feedkeys("n", "n")
"endfunction
"nnoremap * :call TextSearch()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" commands

" leader combos
" d: default
" v: vim
" f: file (or buffer)
" s: search
" c: quick fix
" g: general (a place to put random commands)
" w: wiki (used by vimwiki)
nnoremap <leader>d <nop> 
nnoremap <leader>v <nop>
nnoremap <leader>f <nop>
nnoremap <leader>s <nop>
nnoremap <leader>c <nop>
"nnoremap <leader>w <nop>

" vimrc
execute 'nnoremap <silent> <leader>ve :edit'   s:vimrc . '<cr>'
execute 'nnoremap <silent> <leader>vs :source' s:vimrc . '<cr>'


" escape
inoremap <C-l> <Esc>
vnoremap <C-l> <Esc>
cnoremap <C-l> <C-c>
tnoremap <Esc> <C-\><C-n>
tnoremap <C-l> <C-\><C-n>

" exit
noremap <F12> :qa<CR>

" stop from hitting F1 by accident
map <F1> <Esc>

" turn off highlighted search
noremap <silent> <C-N> :silent noh<CR>

" window size
nnoremap <leader>l 20<C-W>>
nnoremap <leader>h 20<C-W><


" tjump from search
" note: good idea but I need to strip the \< and \> from the regex
"nnoremap <leader>] :tjump <C-R>/<CR>

" build errors
function! LoadErrors()
  set errorfile=errors.err
  :cf
endfunction
command! Err call LoadErrors()

" clang-format
"map <C-K> :pyf ~/bin/clang-format.py<cr>
"imap <C-K> <c-o>:pyf ~/bin/clang-format.py<cr>

execute 'nnoremap <c-K> :pyf' s:clangformat . '<cr>'
execute 'vnoremap <c-K> :pyf' s:clangformat . '<cr>'
execute 'inoremap <c-K> <c-o>:pyf' s:clangformat . '<cr>'


" terminal
tnoremap <C-PageUp> <C-\><C-n>gt
tnoremap <C-PageDown> <C-\><C-n>gT

" movements
nnoremap J }
vnoremap J }
nnoremap K {
vnoremap K {

nnoremap Q J
vnoremap Q J
nnoremap <leader>dQ Q
vnoremap <leader>dQ Q

" Quick Fix
nnoremap <leader>co :copen<CR>
nnoremap <leader>cc :cclose<CR>

" Substitute(Replace)
nnoremap <expr> <leader>sr ':%s/' . @/ . '//gc<LEFT><LEFT><LEFT>'

" file navigation
"nnoremap <silent> <PageDown>  :cprev<CR>
"nnoremap <silent> <PageUp> :cnext<CR>

" toggle highlight cursor column
nnoremap <leader>gl :set cursorcolumn!<CR>

" nerdtree
nnoremap <leader>fe :NERDTreeFind<CR>

" ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
nnoremap <leader>ss :AckFromSearch<CR>

" fzf
nnoremap <leader>fs :Files<CR>
nnoremap <leader>ff :Buffers<CR>
nnoremap <leader>st :Tags<CR>
nnoremap <leader>sT :BTags<CR>
nnoremap <leader>sl :BLines<CR>
nnoremap <leader>sh :Helptags<CR>

" A
nnoremap <leader>fa :A<CR>

" vim-bufkill
noremap <leader>q :BD<CR>
noremap <leader>j :BF<CR>
noremap <leader>k :BB<CR>

" vim-vp4
noremap <leader>pe :Vp4Edit<CR>
noremap <leader>pr :Vp4Revert<CR>

noremap <leader>pd :Vp4Diff<CR>
noremap <leader>ps :Vp4Diff s<CR>

" nvim-gdb

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" local

source ~/.vimrc-local

