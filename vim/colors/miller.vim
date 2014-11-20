"
" Hacked together from ir_black, badwolf, and jellybeans
"
"
" background gradient
" #000000
" #070707
" #141414
" #212121
" #282828
"
"
" brightgravel   #d9cec3
" lightgravel    #998f84
" gravel         #857f78
" mediumgravel   #666462
" deepgravel     #45413b
" deepergravel   #35322d
" darkgravel     #242321
" blackgravel    #1c1b1a
" blackestgravel #141413
"
" #121110
" #070707
"

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "miller"


" General colors
hi Normal           guifg=#f6f3e8     guibg=#101010     gui=NONE
hi NonText          guifg=#35322d     guibg=NONE        gui=NONE

hi Cursor           guifg=#101010     guibg=#FFFFFF     gui=NONE
hi CursorLine       guifg=NONE        guibg=#000000     gui=NONE
hi CursorColumn     guifg=NONE        guibg=#000000     gui=NONE

hi DiffAdd          guifg=NONE        guibg=#45413b     gui=NONE " added line
hi DiffChange       guifg=NONE        guibg=#242321     gui=NONE " changed line
hi DiffText         guifg=NONE        guibg=#45413b     gui=NONE " changed text in a changed line
hi DiffDelete       guifg=#242321     guibg=#000000     gui=NONE

hi LineNr           guifg=#3D3D3D     guibg=#101010     gui=NONE

hi VertSplit        guifg=#202020     guibg=#202020     gui=NONE
hi StatusLine       guifg=#CCCCCC     guibg=#202020     gui=italic
hi StatusLineNC     guifg=#404040     guibg=#202020     gui=NONE

hi Folded           guifg=#a0a8b0     guibg=#384048     gui=NONE
hi FoldColumn       guifg=#a0a8b0     guibg=#384048     gui=NONE
hi Title            guifg=#f6f3e8     guibg=NONE        gui=bold
"hi Visual           guifg=NONE        guibg=#404040     gui=NONE
hi Visual           guifg=#D2EBBE     guibg=#437019     gui=NONE

hi SpecialKey       guifg=#45413b     guibg=#101010     gui=NONE

hi WildMenu         guifg=green       guibg=yellow      gui=NONE
hi PmenuSbar        guifg=#101010     guibg=#FFFFFF     gui=NONE
hi Ignore           guifg=#242321     guibg=#101010     gui=NONE

hi Error            guifg=NONE        guibg=NONE        gui=undercurl
hi ErrorMsg         guifg=#FFFFFF     guibg=#CC2020     gui=BOLD
hi WarningMsg       guifg=#000000     guibg=#CCCC20     gui=BOLD
hi LongLineWarning  guifg=NONE        guibg=#371F1C     gui=underline

" Message displayed in lower left, such as --INSERT--
hi ModeMsg          guifg=#101010     guibg=#C6C5FE     gui=BOLD


hi MatchParen       guifg=#f6f3e8     guibg=#857b6f     gui=BOLD
hi Pmenu            guifg=#f6f3e8     guibg=#444444     gui=NONE
hi PmenuSel         guifg=#101010     guibg=#cae682     gui=NONE
hi Search           guifg=NONE        guibg=#2F2F00     gui=underline

hi SpellCap         guifg=NONE        guibg=NONE        gui=NONE

" Syntax highlighting
hi Comment          guifg=#7C7C7C     guibg=NONE        gui=NONE
hi String           guifg=#A8FF60     guibg=NONE        gui=NONE
hi Number           guifg=#FF73FD     guibg=NONE        gui=NONE

hi Keyword          guifg=#96CBFE     guibg=NONE        gui=NONE
hi PreProc          guifg=#96CBFE     guibg=NONE        gui=NONE
hi Conditional      guifg=#6699CC     guibg=NONE        gui=NONE

hi Todo             guifg=#8f8f8f     guibg=NONE        gui=NONE
hi Constant         guifg=#99CC99     guibg=NONE        gui=NONE

hi Identifier       guifg=#C6C5FE     guibg=NONE        gui=NONE
hi Function         guifg=#FFD2A7     guibg=NONE        gui=NONE
hi Type             guifg=#FFB964     guibg=NONE        gui=NONE
hi Statement        guifg=#6699CC     guibg=NONE        gui=NONE
hi StorageClass     guifg=#c59f6f     guibg=NONE        gui=NONE

hi Special          guifg=#E18964     guibg=NONE        gui=NONE
hi Delimiter        guifg=#00A0A0     guibg=NONE        gui=NONE
hi Operator         guifg=#FFFFFF     guibg=NONE        gui=NONE

hi link Character       Constant
hi link Boolean         Constant
hi link Float           Number
hi link Repeat          Statement
hi link Label           Statement
hi link Exception       Statement
hi link Include         PreProc
hi link Define          PreProc
hi link Macro           PreProc
hi link PreCondit       PreProc
hi link Structure       Type
hi link Typedef         Type
hi link Tag             Special
hi link SpecialChar     Special
hi link SpecialComment  Special
hi link Debug           Special


" Special for XML
hi link xmlTag          Keyword
hi link xmlTagName      Conditional
hi link xmlEndTag       Identifier


" Special for HTML
hi link htmlTag         Keyword
hi link htmlTagName     Conditional
hi link htmlEndTag      Identifier

