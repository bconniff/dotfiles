" Quit when a syntax file was already loaded
if !exists("main_syntax")
	if version < 600
		syntax clear
	elseif exists("b:current_syntax")
		finish
	endif

	" we define it here so that included files can test for it
	let main_syntax='apex'
	syn region apexFold start="{" end="}" transparent fold
endif

" some characters that cannot be in a apex program (outside a string)
syn match   apexError           "[\\@`]"
syn match   apexError           "<<<\|\.\.\|<>\|||=\|&&=\|[^-]->\|\*\/"
syn match   apexOK              "\.\.\."

" keyword definitions
syn keyword apexExternal        native package
syn keyword apexError           goto const switch case
syn keyword apexConditional     if else
syn keyword apexRepeat          while for do
syn keyword apexBoolean         true false
syn keyword apexConstant        null
syn match   apexConstant        "\<[A-Z][A-Z_0-9]\+\>"
syn keyword apexTypedef         this super
syn keyword apexOperator        new instanceof
syn keyword apexType            boolean char byte short int long float double
syn keyword apexType            void
syn match   apexType            "\<[A-Z]\([A-Z0-9_]*[a-z]\)\+[A-Z0-9_]\?\>"
syn keyword apexStatement       return
syn keyword apexStorageClass    static transient final virtual
syn keyword apexExceptions      throw try catch finally
syn keyword apexAssert          assert assertEquals assertNotEquals
syn keyword apexMethodDecl      throws
syn keyword apexClassDecl       extends implements interface

" to differentiate the keyword class from MyClass.class we use a match here
syn match   apexTypedef         "\.\s*\<class\>"ms=s+1
syn match   apexTypedef         "\.\s*\<SObjectType\>"ms=s+1
syn keyword apexClassDecl       enum
syn match   apexClassDecl       "^class\>"
syn match   apexClassDecl       "^trigger\>"
syn match   apexClassDecl       "[^.]\s*\<class\>"ms=s+1
syn match   apexAnnotation      "@\([_$a-zA-Z][_$a-zA-Z0-9]*\.\)*[_$a-zA-Z][_$a-zA-Z0-9]*\>"
syn match   apexClassDecl       "@interface\>"
syn keyword apexBranch          break continue nextgroup=apexUserLabelRef skipwhite
syn match   apexUserLabelRef    "\k\+" contained
syn keyword apexScopeDecl       global public protected private abstract virtual
syn match   apexScopeDecl       "\<with\(out\)\?\s\+sharing\>"
syn keyword apexDmlOperator     insert delete update upsert

" The following cluster contains all apex groups except the contained ones
syn cluster apexTop add=apexExternal,apexError,apexError,apexBranch,apexLabelRegion,apexLabel,apexConditional,apexRepeat,apexBoolean,apexConstant,apexTypedef,apexOperator,apexType,apexType,apexStatement,apexStorageClass,apexAssert,apexExceptions,apexMethodDecl,apexClassDecl,apexClassDecl,apexClassDecl,apexScopeDecl,apexError,apexUserLabel,apexLangObject,apexAnnotation

" Comments
syn keyword apexTodo             contained TODO FIXME XXX
syn region  apexComment          start="/\*" end="\*/" contains=apexTodo,@Spell
syn match   apexLineComment      "//.*" contains=apexTodo,@Spell
syn cluster apexTop add=apexComment,apexLineComment

" Strings and constants
syn match   apexSpecialError     contained "\\."
syn match   apexSpecialCharError contained "[^']"
syn match   apexSpecialChar      contained "\\\([4-9]\d\|[0-3]\d\d\|[\"\\'ntbrf]\|u\x\{4\}\)"
syn region  apexString           start=+'+ end=+'+ end=+$+ contains=apexSpecialChar,apexSpecialError,@Spell
syn match   apexNumber           "\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[lL]\=\>"
syn match   apexNumber           "\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
syn match   apexNumber           "\<\d\+[eE][-+]\=\d\+[fFdD]\=\>"
syn match   apexNumber           "\<\d\+\([eE][-+]\=\d\+\)\=[fFdD]\>"

" unicode characters
syn match   apexSpecial          "\\u\d\{4\}"
syn cluster apexTop add=apexString,apexNumber,apexSpecial,apexStringError

syn match   apexFuncDef          contained +\<\(\crunAs\C\)\@![A-Za-z0-9]\+\>\(\s\|\n\)*\([;({]\)\@=+
syn match   apexFuncSignature    +\<\(if\|for\|while\)\@!\([A-Za-z0-9]*\)\(\s\|\n\)*([^)]*)\(\s\|\n\)*{+ contains=apexFuncDef,apexPunctuation,apexType
syn match   apexPropSignature    +\<\(get\|set\)\(\s\|\n\)*[;{]+ contains=apexFuncDef,apexPunctuation
syn match   apexPunctuation      "[{}<>()\[\],.:;!=|&]"
syn cluster apexTop add=apexPunctuation,apexFuncSignature,apexPropSignature

" apex soql statements
syntax case ignore
syn include @Soql syntax/soql.vim
syn region  soqlStatement        start="\c\[\(\s\|\n\)*\(select\|find\)\>" end="\]" keepend contains=@Soql
syntax case match

" The default highlighting.
hi def link apexFuncDef          Function
hi def link apexPunctuation      Operator
hi def link apexBranch           Conditional
hi def link apexUserLabelRef     apexUserLabel
hi def link apexLabel            Label
hi def link apexUserLabel        Label
hi def link apexConditional      Conditional
hi def link apexRepeat           Repeat
hi def link apexExceptions       Exception
hi def link apexAssert           Statement
hi def link apexStorageClass     StorageClass
hi def link apexMethodDecl       apexStorageClass
hi def link apexClassDecl        apexStorageClass
hi def link apexScopeDecl        apexStorageClass
hi def link apexBoolean          Boolean
hi def link apexSpecial          Special
hi def link apexSpecialError     Error
hi def link apexSpecialCharError Error
hi def link apexString           String
hi def link apexSpecialChar      SpecialChar
hi def link apexNumber           Number
hi def link apexError            Error
hi def link apexStringError      Error
hi def link apexStatement        Statement
hi def link apexOperator         Operator
hi def link apexDmlOperator      Operator
hi def link apexComment          Comment
hi def link apexDocComment       Comment
hi def link apexLineComment      Comment
hi def link apexConstant         Constant
hi def link apexTypedef          Typedef
hi def link apexTodo             Todo
hi def link apexAnnotation       PreProc
hi def link apexCommentTitle     SpecialComment
hi def link apexDocTags          Special
hi def link apexDocParam         Function
hi def link apexDocSeeTagParam   Function
hi def link apexType             Type
hi def link apexExternal         Include
hi def link htmlComment          Special
hi def link htmlCommentPart      Special
hi def link apexSpaceError       Error

let b:current_syntax = 'apex'

if main_syntax == 'apex'
	unlet main_syntax
endif

" vim: ts=4 sw=4 sts=4 noet
