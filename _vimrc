set encoding=utf-8
set runtimepath+=~/dotfiles/vim
source ~/dotfiles/vimrc

if has("gui_running")
  "set guifont=Courier_New:h11:cANSI
  "set guifont=Consolas:h11:cANSI
  set guifont=DejaVu_Sans_Mono:h11:cANSI
  set lines=999 columns=180
endif

"unlet! loaded_perforce

let g:ackprg="perl C:/Users/millef01/bin/ack -H --nocolor --nogroup --column"

map <C-K> :pyf ~/clang-format.py<CR>
imap <C-K> <ESC>:pyf ~/clang-format.py<CR>i

:set diffopt+=iwhite

