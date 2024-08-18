" Vim syntax file
" Language:	XML
" Maintainer:	Johannes Zellner <johannes@zellner.org>
"		Author and previous maintainer:
"		Paul Siegmann <pauls@euronet.nl>
" Last Change:	2013 Jun 07
" Filenames:	*.xml
" $Id: xml.vim,v 1.3 2006/04/11 21:32:00 vimboss Exp $

" CONFIGURATION:
"   syntax folding can be turned on by
"
"      let g:xml_syntax_folding = 1
"
"   before the syntax file gets loaded (e.g. in ~/.vimrc).
"   This might slow down syntax highlighting significantly,
"   especially for large files.
"
" CREDITS:
"   The original version was derived by Paul Siegmann from
"   Claudio Fleiner's html.vim.
"
" REFERENCES:
"   [1] http://www.w3.org/TR/2000/REC-xml-20001006
"   [2] http://www.w3.org/XML/1998/06/xmlspec-report-19980910.htm
"
"   as <hirauchi@kiwi.ne.jp> pointed out according to reference [1]
"
"   2.3 Common Syntactic Constructs
"   [4]    NameChar    ::=    Letter | Digit | '.' | '-' | '_' | ':' | CombiningChar | Extender
"   [5]    Name        ::=    (Letter | '_' | ':') (NameChar)*
"
" NOTE:
"   1) empty tag delimiters "/>" inside attribute values (strings)
"      confuse syntax highlighting.
"   2) for large files, folding can be pretty slow, especially when
"      loading a file the first time and viewoptions contains 'folds'
"      so that folds of previous sessions are applied.
"      Don't use 'foldmethod=syntax' in this case.


" Quit when a syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

syn case match

syn include @vfJavaScript syntax/javascript.vim
unlet b:current_syntax

" mark illegal characters
syn match xmlError "[<&]"

syn match vfFunction +\<[A-Z]\+\>+ contained display
syn match vfPunctuation +[.!\[\](),<>=]+ contained display
syn region vfString start=+\('\|&apos;\)+ skip=+\\\(\'\|&apos;\)+ end=+\('\|&apos;\)+ contained
syn region vfFormula start=+{\(\s\|\n\)*!+ end=+}+ contains=vfFunction,vfPunctuation,vfString

" strings (inside tags) aka VALUES
"
" EXAMPLE:
"
" <tag foo.attribute = "value">
"                      ^^^^^^^
syn region  xmlString contained start=+"+ end=+"+ contains=xmlEntity,vfFormula,@Spell display
syn region  xmlString contained start=+'+ end=+'+ contains=xmlEntity,vfFormula,@Spell display


" punctuation (within attributes) e.g. <tag xml:foo.attribute ...>
"                                              ^   ^
" syn match   xmlAttribPunct +[-:._]+ contained display
syn match   xmlAttribPunct +[:.]+ contained display

" no highlighting for xmlEqual (xmlEqual has no highlighting group)
syn match   xmlEqual +=+ display

" attribute, everything before the '='
"
" PROVIDES: @xmlAttribHook
"
" EXAMPLE:
"
" <tag foo.attribute = "value">
"      ^^^^^^^^^^^^^
"
syn match   xmlAttrib
    \ +[-'"<]\@1<!\<[a-zA-Z:_][-.0-9a-zA-Z:_]*\>\%(['">]\@!\|$\)+
    \ contained
    \ contains=xmlAttribPunct,@xmlAttribHook
    \ display

" namespace spec
"
" PROVIDES: @xmlNamespaceHook
"
" EXAMPLE:
"
" <xsl:for-each select = "lola">
"  ^^^
"
if exists("g:xml_namespace_transparent")
syn match   xmlNamespace
    \ +\(<\|</\)\@2<=[^ /!?<>"':]\+[:]\@=+
    \ contained
    \ contains=@xmlNamespaceHook
    \ transparent
    \ display
else
syn match   xmlNamespace
    \ +\(<\|</\)\@2<=[^ /!?<>"':]\+[:]\@=+
    \ contained
    \ contains=@xmlNamespaceHook
    \ display
endif


" tag name
"
" PROVIDES: @xmlTagHook
"
" EXAMPLE:
"
" <tag foo.attribute = "value">
"  ^^^
"
syn match   xmlTagName
    \ +<\@1<=[^ /!?<>"']\++
    \ contained
    \ contains=xmlNamespace,xmlAttribPunct,@xmlTagHook
    \ display

" no syntax folding:
" - contained attribute removed
" - xmlRegion not defined
"
syn region   xmlTag
    \ matchgroup=xmlTag start=+<[^ /!?<>"']\@=+
    \ matchgroup=xmlTag end=+>+
    \ contains=xmlError,xmlTagName,xmlAttrib,xmlEqual,xmlString,@xmlStartTagHook

syn match   xmlEndTag
    \ +</[^ /!?<>"']\+>+
    \ contains=xmlNamespace,xmlAttribPunct,@xmlTagHook

" &entities; compare with dtd
syn match   xmlEntity                 "&[^; \t]*;" contains=xmlEntityPunct
syn match   xmlEntityPunct  contained "[&.;]"

if exists('g:xml_syntax_folding')

    " The real comments (this implements the comments as defined by xml,
    " but not all xml pages actually conform to it. Errors are flagged.
    syn region  xmlComment
	\ start=+<!+
	\ end=+>+
	\ contains=xmlCommentStart,xmlCommentError
	\ extend
	\ fold

else

    " no syntax folding:
    " - fold attribute removed
    "
    syn region  xmlComment
	\ start=+<!+
	\ end=+>+
	\ contains=xmlCommentStart,xmlCommentError
	\ extend

endif

syn match xmlCommentStart   contained "<!" nextgroup=xmlCommentPart
syn keyword xmlTodo         contained TODO FIXME XXX
syn match   xmlCommentError contained "[^><!]"
syn region  xmlCommentPart
    \ start=+--+
    \ end=+--+
    \ contained
    \ contains=xmlTodo,@xmlCommentHook,@Spell


" CData sections
"
" PROVIDES: @xmlCdataHook
"
syn region    xmlCdata
    \ start=+<!\[CDATA\[+
    \ end=+]]>+
    \ contains=xmlCdataStart,xmlCdataEnd,@xmlCdataHook,@Spell
    \ keepend
    \ extend

" using the following line instead leads to corrupt folding at CDATA regions
" syn match    xmlCdata      +<!\[CDATA\[\_.\{-}]]>+  contains=xmlCdataStart,xmlCdataEnd,@xmlCdataHook
syn match    xmlCdataStart +<!\[CDATA\[+  contained contains=xmlCdataCdata
syn keyword  xmlCdataCdata CDATA          contained
syn match    xmlCdataEnd   +]]>+          contained

" Processing instructions
" This allows "?>" inside strings -- good idea?
syn region  xmlProcessing matchgroup=xmlProcessingDelim start="<?" end="?>" contains=xmlAttrib,xmlEqual,xmlString

syn region  vfScriptTag start=+<script+ keepend end=+>+ contains=xmlTagName,xmlAttrib,xmlEqual,xmlString
syn region  javaScript start=+<script[^&<>]*>+ keepend end=+</script>+me=s-1 contains=@vfJavaScript,vfScriptTag

" The default highlighting.
hi def link xmlTodo		Todo
hi def link xmlTag		Function
hi def link xmlTagName		Function
hi def link xmlEndTag		Identifier
hi def link xmlNamespace	Tag
hi def link xmlEntity		Statement
hi def link xmlEntityPunct	Type

hi def link xmlAttribPunct	Comment
hi def link xmlAttrib		Type

hi def link xmlString		String
hi def link xmlComment		Comment
hi def link xmlCommentStart	xmlComment
hi def link xmlCommentPart	Comment
hi def link xmlCommentError	Error
hi def link xmlError		Error

hi def link xmlProcessingDelim	Comment
hi def link xmlProcessing	Type

hi def link xmlCdata		String
hi def link xmlCdataCdata	Statement
hi def link xmlCdataStart	Type
hi def link xmlCdataEnd		Type

hi def link xmlDocTypeDecl	Function
hi def link xmlDocTypeKeyword	Statement
hi def link xmlInlineDTD	Function

hi def link vfFormula		Special
hi def link vfFunction		Function
hi def link vfPunctuation       Operator
hi def link vfString            String
hi def link vfScriptTag		Function

let b:current_syntax = "xml"

" vim: ts=8
