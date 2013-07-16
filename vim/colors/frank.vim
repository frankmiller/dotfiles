" Vim color file
" Based on ron.vim written by Ron Aaron <ron@ronware.org>

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "frank"

hi Normal        guifg=cyan guibg=black
hi NonText       guifg=brown
hi comment       guifg=green
hi constant      guifg=cyan gui=bold
hi identifier    guifg=cyan gui=NONE
hi statement     guifg=lightblue gui=NONE
hi preproc       guifg=Pink2
hi type          guifg=seagreen gui=bold
hi special       guifg=yellow
hi ErrorMsg      guifg=Black guibg=Red
hi WarningMsg    guifg=Black guibg=Green
hi Error         guibg=Red
hi Todo          guifg=Black guibg=orange
"hi Cursor        guibg=#60a060 guifg=#00ff00
hi Cursor        guibg=white guifg=black
hi CursorLine    guibg=grey10
hi! link CursorColumn CursorLine
hi Search        guibg=lightslateblue
hi IncSearch     gui=NONE guibg=steelblue
hi LineNr        guifg=darkgrey
hi title         guifg=darkgrey
hi StatusLineNC  gui=NONE guifg=lightblue guibg=darkblue
hi StatusLine    gui=bold guifg=cyan guibg=blue
hi label         guifg=gold2
hi operator      guifg=orange
hi clear Visual
hi Visual        term=reverse cterm=reverse gui=reverse
hi Folded        guibg=gray30
hi FoldColumn    guibg=gray30 guifg=white
hi String        guifg=White

hi DiffChange    guibg=darkgreen
hi DiffText      guibg=olivedrab
hi DiffAdd       guibg=darkblue
hi DiffDelete    guibg=grey10 guifg=grey20

hi nontext       guifg=grey25
hi SpecialKey    guifg=grey25

