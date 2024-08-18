set background=dark
hi! clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name = 'bc'

if has("gui_running")
    hi! Cursor guibg=#fa7518 gui=none
    hi! Normal guibg=#080911 guifg=#feffff gui=none

    hi! Normal guifg=white guibg=black gui=none
    hi! Identifier guifg=#afafff gui=none
    hi! PreProc guifg=#00d7ff gui=none
    hi! Statement guifg=#af87d7 gui=none
    hi! SignColumn guibg=black gui=none
    hi! Type guifg=#afd7ff gui=none
    hi! StorageClass guifg=#87afff gui=none
    "hi! String guifg=#d7af5f gui=italic
    hi! String guifg=#d7af5f gui=none
    hi! Character guifg=#af5f00 gui=none
    hi! Constant guifg=#00d7ff gui=none
    "hi! Comment guifg=#767676 gui=italic
    hi! Comment guifg=#767676 gui=none
    hi! Boolean guifg=#ffff00 gui=none
    hi! Number guifg=#00d700 gui=none
    hi! Function guifg=#ff5f5f gui=none
    hi! Operator guifg=#767676 gui=none
    hi! Conditional guifg=#8787ff gui=none
    hi! Repeat guifg=#8787ff gui=none
    hi! Exception guifg=#af00ff gui=none
    hi! StatusLine guibg=#5f5faf guifg=white gui=none
    hi! StatusLineNC guibg=#585858 guifg=#8a8a8a gui=none
    hi! VertSplit guifg=#585858 guibg=#8a8a8a gui=none
    hi! Special guifg=#af5f87 gui=none
    hi! Tag guifg=#8787af gui=none
    hi! SpecialChar guifg=#626262 gui=none
    hi! Visual guifg=#3a3a3a guibg=#8a8a8a gui=none

    hi! Pmenu guifg=#8a8a8a guibg=#444444 gui=none
    hi! PmenuSel guifg=#005f00 guibg=#87ffaf gui=none

    hi! WildMenu guifg=#5f0000 guibg=#ff8700 gui=none

    hi! MatchParen guifg=#ffffaf guibg=#767676 gui=none

    hi! soqlStatement guifg=#ffd7af gui=none
    hi! soqlKeyword guifg=#ff8700 gui=none

    hi! vfFormula guifg=#ffd7af gui=none
    hi! vfFunction guifg=#ff8700 gui=none

    hi! ColorColumn guibg=#3a3a3a gui=none
    hi! SpecialKey guifg=#3a3a3a gui=none

    hi! Search guifg=#ffffaf guibg=NONE gui=underline
elseif &t_Co >= 256
    hi! Identifier ctermfg=147
    hi! PreProc ctermfg=045
    hi! Statement ctermfg=140
    hi! SignColumn ctermbg=black
    hi! Type ctermfg=153
    hi! StorageClass ctermfg=111
    "hi! String ctermfg=179 cterm=italic
    hi! String ctermfg=179
    hi! Character ctermfg=130
    hi! Constant ctermfg=045
    "hi! Comment ctermfg=243 cterm=italic
    hi! Comment ctermfg=243
    hi! Boolean ctermfg=226
    hi! Number ctermfg=040
    hi! Function ctermfg=203
    hi! Operator ctermfg=243
    hi! Conditional ctermfg=105
    hi! Repeat ctermfg=105
    hi! Exception ctermfg=129
    hi! StatusLine ctermfg=061 ctermbg=white
    hi! StatusLineNC ctermfg=240 ctermbg=245
    hi! VertSplit ctermfg=240 ctermbg=245
    hi! Special ctermfg=132
    hi! Tag ctermfg=103
    hi! SpecialChar ctermfg=242
    hi! Visual ctermbg=245 ctermfg=237

    hi! Pmenu ctermfg=245 ctermbg=238
    hi! PmenuSel ctermfg=022 ctermbg=121

    hi! WildMenu ctermbg=208 ctermfg=052

    hi! MatchParen ctermfg=229 ctermbg=243

    "language-specific highlights

    "hi! soqlStatement ctermfg=108
    "hi! soqlKeyword ctermfg=120
    hi! soqlStatement ctermfg=223
    hi! soqlKeyword ctermfg=208

    hi! vfFormula ctermfg=223
    hi! vfFunction ctermfg=208

    hi! ColorColumn ctermbg=237
    hi! SpecialKey ctermfg=237

    hi! Search cterm=underline ctermfg=229 ctermbg=NONE
else
    hi! Identifier ctermfg=12
    hi! PreProc ctermfg=6
    hi! Statement ctermfg=13
    hi! SignColumn ctermbg=black
    hi! Type ctermfg=12
    hi! StorageClass ctermfg=12
    "hi! String ctermfg=3 cterm=italic
    hi! String ctermfg=3
    hi! Character ctermfg=3
    hi! Constant ctermfg=6
    "hi! Comment ctermfg=8 cterm=italic
    hi! Comment ctermfg=8
    hi! Boolean ctermfg=11
    hi! Number ctermfg=10
    hi! Function ctermfg=9
    hi! Operator ctermfg=8
    hi! Conditional ctermfg=12
    hi! Repeat ctermfg=12
    hi! Exception ctermfg=5
    hi! StatusLine ctermfg=4 ctermbg=0
    hi! StatusLineNC ctermfg=8 ctermbg=0
    hi! VertSplit ctermfg=8 ctermbg=8
    hi! Special ctermfg=5
    hi! Tag ctermfg=7
    hi! SpecialChar ctermfg=8
    hi! Visual ctermfg=7 ctermbg=8

    hi! Pmenu ctermfg=7 ctermbg=8
    hi! PmenuSel ctermfg=2 ctermbg=10

    hi! WildMenu ctermfg=1 ctermbg=3

    hi! MatchParen ctermfg=11 ctermbg=8

    hi! soqlStatement ctermfg=9
    hi! soqlKeyword ctermfg=3

    hi! vfFormula ctermfg=9
    hi! vfFunction ctermfg=3

    hi! ColorColumn ctermbg=8
    hi! SpecialKey ctermfg=8

    hi! Search ctermfg=11 ctermbg=NONE cterm=underline
endif
