" file copied from /usr/share/vim/vim73/ftplugin/markdown.vim
" and hacked by frank using tricks from vimwiki

if exists("b:did_ftplugin")
  finish
endif

runtime! ftplugin/html.vim ftplugin/html_*.vim ftplugin/html/*.vim
let b:did_ftplugin = 1

setl spell noet list ts=4 sts=4 sw=4 tw=72 lbr et
setl comments=fb:*,fb:-,fb:+,n:> commentstring=>\ %s
setl ai fo+=tcqln
"setl ai fo=tnro
setl formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^[-*+]\\s\\+

let b:undo_ftplugin .= "|setl cms< com< fo<"

nnoremap <silent> <buffer> <CR>    :call miki#FollowLink()<CR>
nnoremap <silent> <buffer> =       :call miki#AddHeaderLevel()<CR>
nnoremap <silent> <buffer> -       :call miki#RemoveHeaderLevel()<CR>
nnoremap <silent> <buffer> <TAB>   :call miki#FindNextLink()<CR>
nnoremap <silent> <buffer> <S-TAB> :call miki#FindPrevLink()<CR>

nnoremap <silent> <buffer> <BS> :call miki#PopBreadcrumb()<CR>

