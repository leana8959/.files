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

syn match whyOperator "="
syn match whyOperator ":="
syn match whyOperator "+"
syn match whyOperator "-"
syn match whyOperator "*"
syn match whyOperator "/"
syn match whyOperator "\\/"
syn match whyOperator "/\\"
syn match whyOperator "<"
syn match whyOperator ">"
syn match whyOperator "<="
syn match whyOperator ">="

syn match whyIdentifier  /\<\(\l\|_\)\(\w\|'\)*\>/
syn match whyConstructor /\<\(\u\)\(\w\|'\)*\>/
syn match whyStructure   /\<\(\u\)\(\w\|'\)*\>/
syn match whyNum         /-\?\d\+/

syn keyword whyInclude  module use end
syn keyword whyBinding  val let in type
syn keyword whyType     int ref
syn keyword whyKeyword  if then else match with
syn keyword whyKeyword  for while do done
syn keyword whyKeyword  forall
syn keyword whyFunction function predicate assert requires ensures invariant variant
syn keyword WhyResult   result contained

syn region whyParened      matchgroup=NONE start="("       matchgroup=NONE end=")"   contains=ALLBUT,whyParErr
syn region whyBraced       matchgroup=NONE start="{"       matchgroup=NONE end="}"   contains=ALLBUT,whyBraceErr
syn region whyEnsureClause matchgroup=NONE start="ensures" matchgroup=NONE end="}"   contains=whyResult
syn region whyModuleClause matchgroup=NONE start="module"  matchgroup=NONE end=/$/   contains=whyStructure
syn region whyComment                      start="(\*"                     end="\*)" contains=whyComment

syn match whyParErr   ")"
syn match whyBraceErr "}"

hi def link whyIdentifier  Identifier
hi def link whyInclude     Include
hi def link whyStructure   Structure
hi def link whyKeyword     Keyword
hi def link whyFunction    Function
hi def link whyBinding     Keyword
hi def link whyType        Type
hi def link whyNum         Number
hi def link whyResult      Constant
hi def link whyConstructor Function
hi def link whyComment     Comment
hi def link whyOperator    Operator

hi def link whyErr      Error
hi def link whyParErr   whyErr
hi def link whyBraceErr whyErr
