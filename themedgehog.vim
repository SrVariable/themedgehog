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
	execute "highlight" a:group
				\ "guifg="	(has_key(a:style, "fg") ? a:style.fg.gui : "NONE")
				\ "guibg="	(has_key(a:style, "bg") ? a:style.bg.gui : "NONE")
				\ "guisp="	(has_key(a:style, "sp") ? a:style.sp.gui : "NONE")
				\ "gui="	(!empty(s:guiformat) ? s:guiformat : "NONE")
				\ "cterm=NONE"
endfunction

" Colors
let s:black		=	{	"gui": "#1f2024"	}
let s:black2	=	{	"gui": "#2f2f2f"	}
let s:blue		=	{	"gui": "#0067ff"	}
let s:blue2		=	{	"gui": "#919fcd"	}
let s:cyan		=	{	"gui": "#53b2ed"	}
let s:gray		=	{	"gui": "#4d5458"	}
let s:gray2		=	{	"gui": "#617c93"	}
let s:gray3		=	{	"gui": "#707050"	}
let s:green		=	{	"gui": "#36b93b"	}
let s:green2	=	{	"gui": "#3dee3f"	}
let s:orange	=	{	"gui": "#ef7d0e"	}
let s:pink		=	{	"gui": "#ffbbff"	}
let s:pink2		=	{	"gui": "#da27fc"	}
let s:pink3		=	{	"gui": "#f97df9"	}
let s:pink4		=	{	"gui": "#ff99f3"	}
let s:purple	=	{	"gui": "#b450dc"	}
let s:red		=	{	"gui": "#d03636"	}
let s:yellow	=	{	"gui": "#eecc44"	}
let s:white		=	{	"gui": "#bffbff"	}
let s:white2	=	{	"gui": "#ffffff"	}

" === GENERAL START === "
call s:h("TODO",			{	"fg": s:pink,	"bg": s:gray	})
call s:h("Number",			{	"fg": s:white					})
call s:h("Comment",			{	"fg": s:gray2					})
call s:h("Statement",		{	"fg": s:cyan					})
call s:h("Function",		{	"fg": s:green					})
call s:h("Character",		{	"fg": s:white2					})
call s:h("String",			{	"fg": s:white2					})
" === GENERAL END === "                      
                                             
" === VIM START === "                        
call s:h("Normal",			{	"fg": s:white2					})
call s:h("Visual",			{					"bg": s:gray3	})
call s:h("Search",			{	"fg": s:black,	"bg": s:yellow	})
call s:h("LineNr",			{	"fg": s:gray					})
call s:h("NonText",			{	"fg": s:gray					})
call s:h("CursorLineNr",	{	"fg": s:yellow,	"bg": s:gray	})
call s:h("SpecialKey",		{	"fg": s:gray					})
call s:h("ColorColumn",		{					"bg": s:black2	})
" === VIM END === "

" === C START === "
" Create custom match patterns
augroup CFiles
	autocmd!

	"" Match every look like function
	autocmd Filetype c,cpp syntax match cFunction /\k\+\((\)\@=/ " -> ) <- This parenthesis fix the highlighting below

	" Match every look like function excluding definition/declaration
	autocmd Filetype c,cpp syntax match cFunction /\(\(t__*\k*\s\|char\|int\|void\|bool\|double\|float\|long\|short\|size_t\)\s*\%[\*]*\k*(*\)\@<!\k*\ze(/ "")) " The last parenthesis fixes the highlighting below

	" Match hex numbers
	autocmd Filetype c,cpp syntax match cHexZero /0x/
	autocmd Filetype c,cpp syntax match cHex /\(0x\)\@<=\w*/
	autocmd Filetype c,cpp syntax match cHexError /0x\x*\([G-Z]\|[g-z]\)\(\d\|\w\)*/ " Invalid hex number

	" Match binary numbers
	autocmd Filetype c,cpp syntax match cBinaryZero /0b/
	autocmd Filetype c,cpp syntax match cBinary /\(0b\)\@<=\w*/
	autocmd Filetype c,cpp syntax match cBinaryError /0b[0-1]*\([2-9]\|[a-z]\|[A-Z]\)\w*/ " Invalid binary number

	" Match ++ and -- operators
	autocmd Filetype c,cpp syntax match cIncrDecr /++\|--/

	" Match typedef names
	autocmd Filetype c,cpp syntax match cCustomType /\zs\<t_\w*[^;()]/

	" Match preprocessor's name
	autocmd Filetype c,cpp syntax match cPostDefine /\(ifndef.*\n.*\)\@<!\(define\s\)\@<=\(\w*\)/

	" Match (), [] and {}
	autocmd Filetype c,cpp syntax match cParenthesis /(\|)\|[\|]\|{\|}/
augroup END

" Highlighting
call s:h("cDefine",			{	"fg": s:blue2					})
call s:h("cInclude",		{	"fg": s:blue2					})
call s:h("cPostDefine",		{	"fg": s:pink3					})
call s:h("cPreCondit",		{	"fg": s:blue2					})
call s:h("cOperator",		{	"fg": s:yellow					})
call s:h("cFormat",			{	"fg": s:blue					})
call s:h("cType",			{	"fg": s:yellow					})
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
call s:h("cFunction",		{	"fg": s:pink4					})
call s:h("cStatement",		{	"fg": s:cyan					})
call s:h("cCustomType",		{	"fg": s:yellow					})
call s:h("cCustomPointer",	{	"fg": s:yellow					})
call s:h("cIncrDecr",		{	"fg": s:orange					})
call s:h("cIncluded",		{	"fg": s:orange					})
call s:h("cParenthesis",	{	"fg": s:white2					})

" Add bold highlighting
highlight cCustomOperator cterm=bold
highlight cFormat cterm=bold
highlight cConstant cterm=bold
highlight cCustomType cterm=bold
highlight Comment cterm=italic
highlight cType cterm=bold

" Link to the predefined highlight
highlight link cHexError cError
highlight link cBinaryError cError
" === C END === "
