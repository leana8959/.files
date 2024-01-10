" Vim syntax file
" Language: why3
" Filename: *.mlw
" Maintainer: Léana CHIANG

" quit when a syntax file was already loaded
if exists("b:current_syntax") && b:current_syntax == "why3"
  finish
endif

" be case sensitive
syn case match

syn match whyOp "="
syn match whyOp "+"
syn match whyOp "-"
syn match whyOp "*"
syn match whyOp "/"
syn match whyOp "\\/"
syn match whyOp "/\\"
syn match whyOp "<"
syn match whyOp ">"
syn match whyOp "<="
syn match whyOp ">="

syn match whyIdent  /\<\(\l\|_\)\(\w\|'\)*\>/
syn match whyCons   /\<\(\u\)\(\w\|'\)*\>/
syn match whyNum    /-\?\d\+/
syn match whyResult /\<result\>/              contained

syn keyword whyInclude module use end
syn keyword whyBinding val type
syn keyword whyType    int

syn region whyLet     matchgroup=whyKeyword start="\<let\>"     matchgroup=whyKeyword end="\<in\|assert\>" contains=ALLBUT,whyLetErr
syn region whyParened matchgroup=NONE       start="("           matchgroup=NONE       end=")"              contains=ALLBUT,whyParErr
syn region whyBraced  matchgroup=NONE       start="{"           matchgroup=NONE       end="}"              contains=ALLBUT,whyBraceErr
syn region whyEnsures matchgroup=whyKeyword start="\<ensures\>" matchgroup=NONE       end="}"              contains=whyIdent,whyResult,whyOp
syn region whyComment                       start="(\*"                               end="\*)"            contains=whyComment

syn match whyLetErr   "\<in\|assert\>"
syn match whyParErr   ")"
syn match whyBraceErr "}"

hi def link whyIdent     Identifier
hi def link whyInclude   Include
hi def link whyStructure Structure
hi def link whyKeyword   Keyword
hi def link whyBinding   Keyword
hi def link whyType      Type
hi def link whyNum       Number
hi def link whyResult    Structure
hi def link whyCons      Function
hi def link whyComment   Comment
hi def link whyTodo      Todo
hi def link whyOp        Operator

hi def link whyErr      Error
hi def link whyLetErr   whyErr
hi def link whyParErr   whyErr
hi def link whyBraceErr whyErr
