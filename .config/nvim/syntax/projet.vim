" Vim syntax file
" Language:		Projet (adapted from Pascal)
" Maintainer:		Léana CHIANG
" Previous Maintainers:	Xavier Crégut <xavier.cregut@enseeiht.fr>
"			Mario Eusebio <bio@dq.fct.unl.pt>
"			Doug Kearns <dougkearns@gmail.com>
" Last Change:		2024 April 22

" Contributors: Tim Chase <tchase@csc.com>,
"		Stas Grabois <stsi@vtrails.com>,
"		Mazen NEIFER <mazen.neifer.2001@supaero.fr>,
"		Klaus Hast <Klaus.Hast@arcor.net>,
"		Austin Ziegler <austin@halostatue.ca>,
"		Markus Koenig <markus@stber-koenig.de>

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case ignore
syn sync lines=250

syn keyword projetBoolean	vrai faux
syn keyword projetFunction	lire ecrire
syn keyword projetConditional	si alors sinon fsi
syn keyword projetRepeat	ttq faire fait
syn keyword projetStatement	proc var const
syn keyword projetStatement	programme debut fin
syn keyword projetStruct	record
syn keyword projetType		ent bool

syn keyword projetOperator	et ou non div

syn match   projetSymbolOperator      "[+\-*]"
syn match   projetSymbolOperator      "[<>]=*"
syn match   projetSymbolOperator      "<>"
syn match   projetSymbolOperator      ":="

syn region  projetComment	start="{"  end="}"

" " this makes everything red, I guess there was reason it was commented
" syn match   projetIdentifier	"\<[a-zA-Z_][a-zA-Z0-9_]*\>" contained

syn match   projetNumber	"-\=\<\d\+\>"

hi def link projetBoolean		Boolean
hi def link projetComment		Comment
hi def link projetConditional		Conditional
hi def link projetConstant		Constant
hi def link projetFunction		Function
hi def link projetNumber		Number
hi def link projetOperator		Operator
hi def link projetStatement		Statement
hi def link projetSymbolOperator	projetOperator
hi def link projetType			Type
hi def link projetError			Error

let b:current_syntax = "projet"

" vim: nowrap sw=2 sts=2 ts=8 noet:
