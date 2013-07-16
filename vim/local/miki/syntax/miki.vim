
" Quit if syntax file is already loaded
if exists("b:current_syntax")
  finish
endif

syntax spell toplevel

syn cluster mikiInline contains=mikiLink,mikiCompLink,mikiInlineCode,mikiTodo

" Headers
syntax region mikiHeader1 start='^\s*=\{6}[^=]' end='[^=]=\{6}\s*$' keepend oneline contains=@Spell
syntax region mikiHeader2 start='^\s*=\{5}[^=]' end='[^=]=\{5}\s*$' keepend oneline contains=@Spell
syntax region mikiHeader3 start='^\s*=\{4}[^=]' end='[^=]=\{4}\s*$' keepend oneline contains=@Spell
syntax region mikiHeader4 start='^\s*=\{3}[^=]' end='[^=]=\{3}\s*$' keepend oneline contains=@Spell
syntax region mikiHeader5 start='^\s*=\{2}[^=]' end='[^=]=\{2}\s*$' keepend oneline contains=@Spell

" Old headers
"syntax match mikiH1 ".\+\n=\+$"
"syntax match mikiH1 ".\+\n-\+$"
"syntax region mikiH2 start="##\@!"      end="#*\s*$" keepend oneline
"syntax region mikiH2 start="###\@!"     end="#*\s*$" keepend oneline
"syntax region mikiH2 start="####\@!"    end="#*\s*$" keepend oneline
"syntax region mikiH2 start="#####\@!"   end="#*\s*$" keepend oneline
"syntax region mikiH2 start="######\@!"  end="#*\s*$" keepend oneline
"syntax region mikiH2 start="#######\@!" end="#*\s*$" keepend oneline

" [[Links]] and [Compound][Links]
syntax region mikiLink matchgroup=mikiLinkDelim start='\[\[\%([^\]]\+\]\]\)\@=' end='\]\]' oneline keepend skipwhite
syntax match mikiCompLink '\[\_[^\[\]]\+\]\s*\n\?\s*([^)]\+)' contains=mikiCompLinkText,mikiCompLinkLink
syntax region mikiCompLinkText matchgroup=mikiLinkDelim start='\[' end='\]' keepend contained
syntax region mikiCompLinkLink matchgroup=mikiLinkDelim start='('  end=')'  keepend contained

" Code Block
syntax region mikiCode start='^    \|\t' end='$' oneline keepend
syntax region mikiInlineCode matchgroup=mikiInlineCodeDelim start='`' end='`' keepend

" **bold multiple words**
syntax match mikiBold /\*\*[^*]\+\*\*/

""//italic multiple words//
"syntax match mikiItalic /\/\/[^/]\+\/\//

""__emphasis multiple words__
"syntax match mikiEmphasis /__[^_]\+__/


" todo items
syntax match mikiTodo '\%(TODO\|XXX\)'

" Bullet Lists
syntax match mikiList1 '^[*\-+] \S.*$\n\(  [^\s*\-+].*$\n\)*' contains=@mikiInline,@Spell,mikiList1Code
syntax match mikiList2 '^ \{2}[*\-+] \S.*$\n\( \{2}  [^\s*\-+].*$\n\)*' contains=@mikiInline,@Spell,mikiList2Code
syntax match mikiList3 '^ \{4}[*\-+] \S.*$\n\( \{4}  [^\s*\-+].*$\n\)*' contains=@mikiInline,@Spell,mikiList3Code
syntax match mikiList4 '^ \{6}[*\-+] \S.*$\n\( \{6}  [^\s*\-+].*$\n\)*' contains=@mikiInline,@Spell,mikiList4Code
syntax region mikiList1Code start='^ \{6}'  end='$' oneline keepend contained
syntax region mikiList2Code start='^ \{8}'  end='$' oneline keepend contained
syntax region mikiList3Code start='^ \{10}' end='$' oneline keepend contained
syntax region mikiList4Code start='^ \{12}' end='$' oneline keepend contained


syntax sync fromstart

hi def mikiHeader1 guifg=White guibg=Grey25 gui=bold ctermfg=Red       term=bold cterm=bold
hi def mikiHeader2 guifg=#80e090 gui=bold ctermfg=Green     term=bold cterm=bold
hi def mikiHeader3 guifg=#6090e0 gui=bold ctermfg=Blue      term=bold cterm=bold
hi def mikiHeader4 guifg=#c0c0f0 gui=bold ctermfg=White     term=bold cterm=bold
hi def mikiHeader5 guifg=#e0e0f0 gui=bold ctermfg=White     term=bold cterm=bold

"hi def mikiBold term=bold cterm=bold gui=bold
hi def link mikiBold special
"hi def mikiItalic term=italic cterm=italic gui=italic
"hi def link mikiEmphasis     Constant

hi def link mikiCode            String
hi def link mikiList1Code       mikiCode
hi def link mikiList2Code       mikiCode
hi def link mikiList3Code       mikiCode
hi def link mikiList4Code       mikiCode
hi def link mikiInlineCode      mikiCode
hi def link mikiInlineCodeDelim Delimiter
hi def link mikiLink            Underlined
hi def link mikiCompLinkText    mikiLink
hi def link mikiCompLinkLink    Float
"hi def link mikiCompLinkText    mikiHeader1
"hi def link mikiCompLinkLink    Todo
hi def link mikiListMarker      Comment
hi def link mikiTodo            Todo

"hi def link mikiH1          Error
"hi def link mikiH2          Error
"hi def link mikiList1       Type

let b:current_syntax = "miki"

