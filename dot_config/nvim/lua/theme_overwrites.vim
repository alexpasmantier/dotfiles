" String         xxx links to Constant
" Constant       xxx ctermfg=217 guifg=#ffa0a0
" Character      xxx links to Constant
" Number         xxx links to Constant
" Boolean        xxx links to Constant
" Float          xxx links to Number
" Function       xxx links to Identifier
" Identifier     xxx ctermfg=87 guifg=#40ffff
" Conditional    xxx links to Statement
" Statement      xxx ctermfg=227 guifg=#ffff60
" Repeat         xxx links to Statement
" Label          xxx links to Statement
" Operator       xxx links to Statement
" Keyword        xxx links to Statement
" Exception      xxx links to Statement
" Include        xxx links to PreProc
" PreProc        xxx ctermfg=213 guifg=#ff80ff
" Define         xxx links to PreProc
" Macro          xxx links to PreProc
" PreCondit      xxx links to PreProc
" StorageClass   xxx links to Type
" Type           xxx ctermfg=83 guifg=#60ff60
" Structure      xxx links to Type
" Typedef        xxx links to Type
" Tag            xxx links to Special
" Special        xxx ctermfg=214 guifg=#ffa500
" SpecialChar    xxx links to Special
" Delimiter      xxx links to Special
" SpecialComment xxx links to Special
" Debug          xxx links to Special

" always have comments in italic style
hi Comment cterm=italic gui=italic guifg=#555555


" change cursorline to make comments visible
hi CursorLine guibg=#151515
hi CursorLineNr guibg=#151515
" change hover float window background and border color
hi NormalFloat guibg=#000000
hi FloatBorder guifg=#9e2222
" change MatchParen
hi MatchParen guibg=#000000 guifg=#ff0000
" change split bar
hi VertSplit guibg=bg guifg=fg
" neotree float title
hi NeoTreeFloatTitle guibg=bg guifg=#ff0000
