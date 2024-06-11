" - License:		MIT
" - File:			themedgehog.vim
" - Maintainer:		Rojohn Ibana (SrVariable)
" - URL:			https://github.com/SrVariable/themedgehog

if !has("gui_running") && &t_Co < 256
	finish
endif

if exists("syntax_on")
	syntax reset
endif

set background=dark

" Activate cursor line highlighting
set cursorline
hi clear CursorLine

" Function to apply styles
function! s:h(group, style)
	let s:guiformat = "bold"
	if has_key(a:style, "format")
		let s:guiformat = a:style.format
	endif
	let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm : "NONE")
	let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm : "NONE")
	execute "highlight" a:group
				\ "guifg="	(has_key(a:style, "fg") ? a:style.fg.gui : "NONE")
				\ "guibg="	(has_key(a:style, "bg") ? a:style.bg.gui : "NONE")
				\ "guisp="	(has_key(a:style, "sp") ? a:style.sp.gui : "NONE")
				\ "gui="	(!empty(s:guiformat) ? s:guiformat : "NONE")
				\ "ctermfg=" . l:ctermfg
				\ "ctermbg=" . l:ctermbg
				\ "cterm=NONE"
endfunction

" @--------------------------------------------------------------------------@ "
" |                                 COLORS                                   | "
" @--------------------------------------------------------------------------@ "

let s:black		=	{	"gui": "#1f2024",	"cterm": 0		}
let s:black2	=	{	"gui": "#2f2f2f",	"cterm": 235	}
let s:blue		=	{	"gui": "#0067ff",	"cterm": 12		}
let s:blue2		=	{	"gui": "#919fcd",	"cterm": 74		}
let s:blue3		=	{	"gui": "#043174",	"cterm": 74		}
let s:cyan		=	{	"gui": "#53b2ed",	"cterm": 81		}
let s:gray		=	{	"gui": "#4d5458",	"cterm": 8		}
let s:gray2		=	{	"gui": "#617c93",	"cterm": 8		}
let s:gray3		=	{	"gui": "#707050",	"cterm": 243	}
let s:gray4		=	{	"gui": "#484747",	"cterm": 243	}
let s:green		=	{	"gui": "#36b93b",	"cterm": 48		}
let s:green2	=	{	"gui": "#3dee3f",	"cterm": 47		}
let s:orange	=	{	"gui": "#ef7d0e",	"cterm": 208	}
let s:pink		=	{	"gui": "#ffbbff",	"cterm": 219	}
let s:pink2		=	{	"gui": "#f97df9",	"cterm": 211	}
let s:purple	=	{	"gui": "#b450dc",	"cterm": 134	}
let s:purple2	=	{	"gui": "#d88cff",	"cterm": 135	}
let s:red		=	{	"gui": "#d03636",	"cterm": 9		}
let s:red2		=	{	"gui": "#850606",	"cterm": 9		}
let s:yellow	=	{	"gui": "#eecc44",	"cterm": 185	}
let s:yellow2	=	{	"gui": "#7E8212",	"cterm": 185	}
let s:white		=	{	"gui": "#ffffff",	"cterm": 231	}
let s:white2	=	{	"gui": "#e8e8e8",	"cterm": 254	}

" @--------------------------------------------------------------------------@ "
" |                             General Section                              | "
" @--------------------------------------------------------------------------@ "

call s:h("Normal",			{	"fg": s:white					})
call s:h("Visual",			{					"bg": s:gray3	})
call s:h("Search",			{	"fg": s:black,	"bg": s:yellow	})
call s:h("LineNr",			{	"fg": s:gray					})
call s:h("NonText",			{	"fg": s:gray					})
"call s:h("CursorLine",		{					"bg": s:black2	})
call s:h("CursorLineNr",	{	"fg": s:yellow,	"bg": s:gray	})
call s:h("SpecialKey",		{	"fg": s:gray					})
call s:h("ColorColumn",		{					"bg": s:black2	})
call s:h("TODO",			{	"fg": s:pink,	"bg": s:gray	})
call s:h("Number",			{	"fg": s:white					})
call s:h("Comment",			{	"fg": s:gray2					})
call s:h("Statement",		{	"fg": s:yellow					})
call s:h("Function",		{	"fg": s:green					})
call s:h("Character",		{	"fg": s:white					})
call s:h("String",			{	"fg": s:white					})
call s:h("SpecialChar",		{	"fg": s:orange					})

" @--------------------------------------------------------------------------@ "
" |                               Vim Section                                | "
" @--------------------------------------------------------------------------@ "

call s:h("vimOption",		{	"fg": s:green2					})
call s:h("vimCommand",		{	"fg": s:yellow					})
call s:h("vimFuncname",		{	"fg": s:white					})
call s:h("vimVar",			{	"fg": s:cyan					})
call s:h("vimF8Var",		{	"fg": s:red					})

highlight vimVar cterm=bold

" @--------------------------------------------------------------------------@ "
" |                                C Section                                 | "
" @--------------------------------------------------------------------------@ "

" Create custom match patterns
augroup CFiles
	autocmd!

	" Match hex numbers
	autocmd Filetype c,cpp syn match cHexZero /0x/
	autocmd Filetype c,cpp syn match cHex /\(0x\)\@<=\w*/
	autocmd Filetype c,cpp syn match cHexError /0x\x\([G-Z]\|[g-z]\)\(\d\|\w\)*/

	" Match binary numbers
	autocmd Filetype c,cpp syn match cBinaryZero /0b/
	autocmd Filetype c,cpp syn match cBinary /\(0b\)\@<=\w*/
	autocmd Filetype c,cpp syn match cBinaryError /0b[0-1]*\([2-9]\|[a-z]\|[A-Z]\)\w*/

	" Match ++ and -- operators
	autocmd Filetype c,cpp syn match cIncrDecr /++\|--/

	" Match typedef names
	autocmd Filetype c,cpp syn match cCustomType /\zs\<t_\w*[^;()]/
	autocmd Filetype c,cpp syn match cType /\w*_t\ze\(\s\|)\)/
	autocmd Filetype c,cpp syn match cType /\C\<\u\l\w*\ze\(\s\|;\|)\)/

	" Match preprocessor's name
	autocmd Filetype c,cpp syn match cPostDefine /\(ifndef.*\n.*\)\@<!\(define\s\)\@<=\(\w*\)/

	"Match parenthesis
	autocmd Filetype c,cpp syn match cParenthesis /(\|)\|[\|]\|{\|}/

	" Match FILENO keywords
	autocmd Filetype c,cpp syn keyword cFileDescriptors STDIN_FILENO STDOUT_FILENO STDERR_FILENO
augroup END " CFiles

" Highlighting
call s:h("cDefine",			{	"fg": s:blue2					})
call s:h("cInclude",		{	"fg": s:blue2					})
call s:h("cPostDefine",		{	"fg": s:pink2					})
call s:h("cPreCondit",		{	"fg": s:blue2					})
call s:h("cOperator",		{	"fg": s:yellow					})
call s:h("cFormat",			{	"fg": s:blue					})
call s:h("cType",			{	"fg": s:purple2					})
call s:h("cString",			{	"fg": s:green2					})
call s:h("cStorageClass",	{	"fg": s:yellow					})
call s:h("cConstant",		{	"fg": s:orange					})
call s:h("cStructure",		{	"fg": s:yellow					})
call s:h("cTypedef",		{	"fg": s:yellow					})
call s:h("MatchParen",		{	"fg": s:blue2,	"bg": s:gray3	})
call s:h("cBinaryZero",		{	"fg": s:red						})
call s:h("cOctalZero",		{	"fg": s:red						})
call s:h("cHexZero",		{	"fg": s:red						})
call s:h("cBinary",			{	"fg": s:white					})
call s:h("cOctal",			{	"fg": s:white					})
call s:h("cHex",			{	"fg": s:white					})
call s:h("cFunction",		{	"fg": s:cyan					})
call s:h("cStatement",		{	"fg": s:purple					})
call s:h("cCustomPointer",	{	"fg": s:yellow					})
call s:h("cIncrDecr",		{	"fg": s:orange					})
call s:h("cIncluded",		{	"fg": s:orange					})
call s:h("cParenthesis",	{	"fg": s:white					})
call s:h("cParenthesis",	{	"fg": s:white					})
call s:h("cCharacter",		{	"fg": s:green2					})

" Add bold highlighting
highlight cCustomOperator cterm=bold
highlight CursorLineNr cterm=bold
highlight cFormat cterm=bold
highlight cConstant cterm=bold
highlight Statement cterm=bold
highlight cStatement cterm=bold

" Link to the predefined highlight
highlight link cHexError cError
highlight link cBinaryError cError
highlight link cCustomType cType
highlight link cFileDescriptors cConstant

" @--------------------------------------------------------------------------@ "
" |                               C++ Section                                | "
" @--------------------------------------------------------------------------@ "

augroup CppFiles
	autocmd!

	" Match namespace
	autocmd Filetype cpp syn match cppNamespace /\w*\ze::/ contains=cppNamespaceColon
	autocmd Filetype cpp syn match cppNamespaceColon /::/ contained
augroup END " CppFiles

call s:h("cppNamespace",		{	"fg": s:red					})
call s:h("cppNamespaceColon",	{	"fg": s:yellow				})

highlight link cppConstant cConstant
highlight link cppStructure cStructure
highlight link cppType cType
highlight link cppString cString
highlight link cppCustomType cType
highlight link cppBoolean cConstant
highlight link cppType cType
highlight cppNamespace cterm=bold

" @--------------------------------------------------------------------------@ "
" |                             Python Section                               | "
" @--------------------------------------------------------------------------@ "

augroup PythonFiles
	autocmd!

	" Match octal numbers
	autocmd Filetype python syn match pythonOctal /0\@<=\w*/

	" Match hex numbers
	autocmd Filetype python syn match pythonHexZero /0x/
	autocmd Filetype python syn match pythonHex /\(0x\)\@<=\w*/

	" Match binary numbers
	autocmd Filetype python syn match pythonBinaryZero /0b/
	autocmd Filetype python syn match pythonBinary /\(0b\)\@<=\w*/

	" Match python comments
	autocmd Filetype python syn region pythonDocstring  start=+^\s*[uU]\?[rR]\?"""+ end=+"""+ keepend excludenl contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,pythonSpaceError
	autocmd Filetype python syn region pythonDocstring  start=+^\s*[uU]\?[rR]\?'''+ end=+'''+ keepend excludenl contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,pythonSpaceError
augroup END " PythonFiles

call s:h("pythonAsync",			{	"fg": s:yellow					})
call s:h("pythonFunction",		{	"fg": s:white					})
call s:h("pythonStatement",		{	"fg": s:yellow					})
call s:h("pythonInclude",		{	"fg": s:blue2					})
call s:h("pythonConditional",	{	"fg": s:yellow					})
call s:h("pythonRepeat",		{	"fg": s:yellow					})
call s:h("pythonOperator",		{	"fg": s:yellow					})
call s:h("pythonString",		{	"fg": s:green2					})
call s:h("pythonRawString",		{	"fg": s:red						})
call s:h("pythonQuotes",		{	"fg": s:green2					})
call s:h("pythonTripleQuotes",	{	"fg": s:gray2					})
call s:h("pythonComment",		{	"fg": s:gray2					})
call s:h("pythonBuiltin",		{	"fg": s:cyan					})
call s:h("pythonHexZero",		{	"fg": s:red						})
call s:h("pythonBinaryZero",	{	"fg": s:red						})
call s:h("pythonOctalZero",		{	"fg": s:blue					})
call s:h("pythonHexZero",		{	"fg": s:red						})
call s:h("pythonBinary",		{	"fg": s:white					})
call s:h("pythonOctal",			{	"fg": s:white					})
call s:h("pythonHex",			{	"fg": s:white					})
call s:h("pythonDecorator",		{	"fg": s:orange					})
call s:h("pythonDecoratorName",	{	"fg": s:orange					})

highlight pythonStatement cterm=bold
highlight pythonAsync cterm=bold
highlight pythonConditional cterm=bold
highlight pythonRepeat cterm=bold

highlight link pythonDocstring pythonComment

" @--------------------------------------------------------------------------@ "
" |                              Make Section                                | "
" @--------------------------------------------------------------------------@ "

augroup MakeFiles
	autocmd!
	autocmd Filetype make syn match makeMacroTarget /\$(\w*):$/
augroup END " MakeFiles

call s:h("makeIdent",			{	"fg": s:blue2					})
call s:h("makeTarget",			{	"fg": s:yellow					})
call s:h("makePreCondit",		{	"fg": s:purple					})
call s:h("makeCommands",		{	"fg": s:white					})
call s:h("makeStatement",		{	"fg": s:red						})
call s:h("makeExport",			{	"fg": s:red						})

highlight makeTarget cterm=bold
highlight makeStatement cterm=bold
highlight link makeMacroTarget makeTarget

" @--------------------------------------------------------------------------@ "
" |                            Markdown Section                              | "
" @--------------------------------------------------------------------------@ "

augroup MarkdownFiles
	autocmd!

	" Match Note blocks
	autocmd Filetype markdown syn region markdownNote start=/>\s*\[!NOTE\]/ end=/^\s*$\|^\s*[^>]/  contains=markdownNoteTitle
	autocmd Filetype markdown syn match markdownNoteTitle /\[!NOTE\]/ contained

	" Match Tip blocks
	autocmd Filetype markdown syn region markdownTip start=/>\s*\[!TIP\]/ end=/^\s*$\|\n\%^\s*[^>]/ contains=markdownTipTitle
	autocmd Filetype markdown syn match markdownTipTitle /\[!TIP\]/ contained

	" Match Warning blocks
	autocmd Filetype markdown syn region markdownWarning start=/>\s*\[!WARNING\]/ end=/^\s*$\|\n\%^\s*[^>]/ contains=markdownWarningTitle
	autocmd Filetype markdown syn match markdownWarningTitle /\[!WARNING\]/ contained
augroup END " MarkdownFiles

call s:h("markdownCodeBlock",		{	"fg": s:white,	"bg": s:gray4	})
call s:h("markdownBlock",			{	"fg": s:white,	"bg": s:gray4	})
call s:h("markdownCode",			{	"fg": s:white,	"bg": s:gray4	})
call s:h("markdownH1",				{	"fg": s:yellow					})
call s:h("markdownH2",				{	"fg": s:yellow					})
call s:h("markdownH3",				{	"fg": s:yellow					})
call s:h("markdownH4",				{	"fg": s:yellow					})
call s:h("markdownH5",				{	"fg": s:yellow					})
call s:h("markdownH6",				{	"fg": s:yellow					})
call s:h("markdownH1Delimiter",		{	"fg": s:yellow					})
call s:h("markdownH2Delimiter",		{	"fg": s:yellow					})
call s:h("markdownH3Delimiter",		{	"fg": s:yellow					})
call s:h("markdownH4Delimiter",		{	"fg": s:yellow					})
call s:h("markdownH5Delimiter",		{	"fg": s:yellow					})
call s:h("markdownH6Delimiter",		{	"fg": s:yellow					})
call s:h("markdownNote",			{	"fg": s:white, "bg": s:blue3	})
call s:h("markdownNoteTitle",		{	"fg": s:white, "bg": s:blue3	})
call s:h("markdownTip",				{	"fg": s:white, "bg": s:yellow2	})
call s:h("markdownTipTitle",		{	"fg": s:white, "bg": s:yellow2	})
call s:h("markdownWarning",			{	"fg": s:white, "bg": s:red2		})
call s:h("markdownWarningTitle",	{	"fg": s:white, "bg": s:red2		})


highlight markdownH1 cterm=bold
highlight markdownH2 cterm=bold
highlight markdownH3 cterm=bold
highlight markdownH4 cterm=bold
highlight markdownH5 cterm=bold
highlight markdownH6 cterm=bold
highlight markdownNoteTitle cterm=bold
highlight markdownTipTitle cterm=bold
highlight markdownWarningTitle cterm=bold
