" Vim syntax file
" Language: skeletal semantics
" Filename: *.sk *.ski
" Maintainer: Victoire Noizet
" Latest revision: 28 Feb. 2020

" quit when a syntax file was already loaded
if exists("b:current_syntax") && b:current_syntax == "skel"
  finish
endif

" skel is case sensitive
syn case match

syn match skelLCI         /\<\(\l\|_\)\(\w\|'\)*\>/
syn match skelConstructor /\<\(\u\)\(\w\|'\)*\>/

syn keyword  PreProc         require clone open
syn keyword  skelDeclaration val type binder
syn keyword  skelTodo        contained TODO FIXME XXX NOTE LATER
syn keyword  skelOr          contained or
syn keyword  skelWith        contained with
syn match    skelQuestion    contained "?"

" Errors
syn match skelOrErr     "\<or\>"
syn match skelOrErr     "\<with\>"
syn match skelEndErr    "\<end\>"
syn match skelInErr     "\<in\>"
syn match skelAngleErr  ">"
syn match skelParErr    ")"
syn match skelCommaErr  ","

syn region skelBranching matchgroup=skelStruct start="\<branch\>" matchgroup=skelStruct end="\<end\>" contains=ALLBUT,skelOrErr,skelEndErr
syn region skelBranching matchgroup=skelStruct start="\<match\>"  matchgroup=skelStruct end="\<end\>" contains=ALLBUT,skelWithErr,skelEndErr
syn region skelLetIn     matchgroup=skelStruct start="\<let\>"    matchgroup=skelStruct end="\<in\>"  contains=ALLBUT,skelInErr

syn region skelAngleStruct matchgroup=NONE start="<" matchgroup=NONE end=">" contains=ALLBUT,skelAngleErr,skelCommaErr
syn region skelParenStruct matchgroup=NONE start="(" matchgroup=NONE end=")" contains=ALLBUT,skelParErr,skelCommaErr

syn region skelComment           start="(\*"   end="\*)" contains=skelTodo,skelComment
" syn region skelMeaningfulComment start="(\*\*" end="\*)" contains=skelComment

syn match skelKeyChar ":"
syn match skelKeyChar "→"
syn match skelKeyChar "->"
syn match skelKeyChar "λ"
syn match skelKeyChar "\\"
syn match skelKeyChar "|"
syn match skelKeyChar "="
syn match skelKeyChar ";"

hi def link skelLCI               Identifier
hi def link skelDeclaration       Keyword
hi def link skelConstructor       Function
hi def link skelComment           Comment
hi def link skelMeaningfulComment Comment
hi def link skelTodo              Todo
hi def link skelOr                Statement
hi def link skelWith              Statement

hi def link skelErr       Error
hi def link skelOrErr     skelErr
hi def link skelWithErr   skelErr
hi def link skelInErr     skelErr
hi def link skelParErr    skelErr
hi def link skelEndErr    skelErr
hi def link skelAngleErr  skelErr
hi def link skelCommaErr  skelErr

hi def link skelKeyChar   Operator
hi def link skelStruct    Statement
hi def link skelBranching Bold

""""" Folding of comments of type (** * sthg *)
" syn region skelCommentLvl1 keepend transparent start="(\* \* " end="(\* \*"me=e-7 skip="(\* \*\*" contains=ALL fold
" syn region skelCommentLvl2 keepend transparent start="(\* \*\* " end="(\* \*"me=e-7 skip="(\* \*\*\*" contains=ALL fold
" syn region skelCommentLvl3 keepend transparent start="(\* \*\*\* " end="(\* \*"me=e-7 skip="(\* \*\*\*\*" contains=ALL fold
" syn region skelCommentLvl4 keepend transparent start="(\* \*\*\*\* " end="(\* \*"me=e-7 skip="(\* \*\*\*\*\*" contains=ALL fold
" syn region skelCommentLvl5 keepend transparent start="(\* \*\*\*\*\* " end="(\* \*"me=e-7 contains=ALL fold
set foldmethod=syntax
