
if exists("g:loaded_miki_auto") || &cp
  finish
endif
let g:loaded_miki_auto = 1

let g:miki_breadcrumbs = []

let s:linkRx = '\[\[[^\[\]]\+\]\]\|\[[^\[\]]\+\]\s*\n\?\s*([^)]\+)'

function! miki#GetLinkAtCursor()
  let col = col('.') - 1
  let line = getline('.')
  let ebeg = -1
  let cont = match(line, s:linkRx, 0)
  while (ebeg >= 0 || (0 <= cont) && (cont <= col))
    let contn = matchend(line, s:linkRx, cont)
    if (cont <= col) && (col < contn)
      let ebeg = match(line, s:linkRx, cont)
      let elen = contn - ebeg
      break
    else
      let cont = match(line, s:linkRx, contn)
    endif
  endwh
  if ebeg >= 0
    let w = strpart(line, ebeg, elen)
    if w =~ '^\[\['
      " get rid of [[ and ]]
      let w = strpart(w, 2, strlen(w)-4)

      " we want "link" from [[link|link desc]]
      if w =~ '|'
        let w = split(w, "|")[0]
      endif
    elseif w =~ '^\[[^\[]'
      let w = substitute( w, '\[[^\]]\+\](\([^)]\+\))', '\1', '')
    endif
    return w
  else
    return ""
  endif
endf

function! miki#FollowLink()

  "let line  = ""
  "let start = line('.')
  "let end   = line('$')
  "if 1 < start
  "  let line = getline( start - 1 )
  "endif
  "let line = line . getline( start )
  "if start < end
  "  let line = line . getline( start + 1 )
  "endif

  "echo line

  let link = miki#GetLinkAtCursor()
  echo link

  let basePath = expand( "%:p:h" ).'/'
  if link =~ '^/.*'
      let basePath=expand('~/e')
  endif

  if link =~ '.pdf\(:\d\+\)\?$'
    let linklist = split( link, ":" )
    let link = get( linklist, 0, "" )
    let page = get( linklist, 1, "" )
    if page == ""
      call system( "evince " . basePath . link . " &" )
    else
      call system( "evince -p " . page . " " . basePath . link . " &" )
    endif
  elseif link =~ '^https\=://'
    let command = "firefox \"" . link . "\" &"
    call system( command )
    echo command
  elseif link != ""
    let link = substitute(link, ' ', '_', 'g')
    call add( g:miki_breadcrumbs, expand( "%:p" ) )
    execute ':e '. basePath . link . ".miki"
  endif

endfunction

function! miki#PopBreadcrumb()
  if !empty( g:miki_breadcrumbs )
    "echo string( g:miki_breadcrumbs )
    let last = g:miki_breadcrumbs[-1]
    let g:miki_breadcrumbs = g:miki_breadcrumbs[0:-2]
    execute ':e '. last
  endif
endfunction

function! miki#CountFirstSymbol(line)
  let first_sym = matchstr(a:line, '\S')
  return len(matchstr(a:line, first_sym.'\+'))
endfunction

" ====== Head 1 ======
" ===== head 2 =====
" ==== head 3 ====
" === head 4 ===
" == head 5 ==

function! miki#AddHeaderLevel()
  let lnum = line('.')
  let line = getline(lnum)

  if line =~ '^\s*$'
    return
  endif

  if line =~ '^\s*=\(=\+\).\+\1=\s*$'
    let level = miki#CountFirstSymbol(line)
    if level > 2
      let old = repeat('=', level)
      let new = repeat('=', level - 1)
      let line = substitute(line, old, new, 'g')
    endif
    call setline(lnum, line)
  else
    let line = substitute(line, '^\s*', '&====== ', '')
    let line = substitute(line, '\s*$', ' ======&', '')
    call setline(lnum, line)
  endif
endfunction

function! miki#RemoveHeaderLevel()
  let lnum = line('.')
  let line = getline(lnum)

  if line =~ '^\s*\(=\+\).\+\1\s*$'
    let level = miki#CountFirstSymbol(line)
    if level < 6
      let line = substitute(line, '\(=\+\).\+\1', '=&=', '')
    else
      let line = substitute(line, '======\s*\([^=]\+\)======', '\1', '')
      let line = substitute(line, '\s*$', '', '')
    endif
  endif

  call setline(lnum, line)
endfunction


function! miki#FindNextLink()
  let match_line = search( s:linkRx, 's' )
  if match_line == 0
    echomsg "miki: link not found."
  endif
endfunction

function! miki#FindPrevLink()
  let match_line = search( s:linkRx, 'sb' )
  if match_line == 0
    echomsg "miki: link not found."
  endif
endfunction

