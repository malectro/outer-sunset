highlight clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

let g:colors_name='OuterSunset'
let s:group_prefix='OuterSunset'

" set color variables
" [light, dark]
let s:colors = #{
\  fg: ['#e7e7e7', '#bababa', '#9e9e9e'],
\  bg: ['#222222', '#3f3f3f', '#5b5b5b'],
\  pink: ['#e5b1c0', '#B68392'],
\  yellow: ['#FFCE72', '#f2ba63'],
\  rose: ['#b0a1c8', '#685589'],
\  orange: ['#ffa372', '#e1674a'],
\  red: ['#ff7272', '#c85151'],
\  green: ['#93e89b', '#65b26d'],
\  blue: ['#72f7ff', '#27c1c1'],
\  purple: ['#f4b1ff', '#ab4cbb'],
\ }

" helper functions
function! Hi(name, ...)
  let histring = ['hi', a:name] + a:000
  execute join(histring, ' ')
endfunction

" Arguments name: group name, options...
function! HiNamespace(name, ...)
  let histring = ['hi', s:group_prefix . '_' . a:name] + a:000
  " echo join(histring, ' ')
  execute join(histring, ' ')
endfunction

function! LocalGroup(name)
  s:group_prefix . '_' . name
endfunction

" create color groups
" GroupNamespace_color_style
"  bold, italic, sign
for [name, colors] in items(s:colors)
  let i = 0
  for color in colors
    call HiNamespace(name . '_' . i, 'guifg=' . color)
    for style in ['bold', 'italic']
      call HiNamespace(name . '_' . i . '_' . style, 'guifg=' . color, 'gui=' . style)
    endfor
    call HiNamespace(name . '_' . i . '_sign', 'guifg=' . color, 'guibg=' . s:colors.bg[1], 'gui=inverse,')
    let i += 1
  endfor
endfor

" local generalizations
hi! link OuterSunset_Important OuterSunset_red_0
hi! link OuterSunset_Macro OuterSunset_rose_0
hi! link OuterSunset_Value OuterSunset_purple_0

" UI
" Cursor
call Hi('CursorLine', 'guibg=' . s:colors.bg[1])
hi! link CursorColumn CursorLine
call Hi('Cursor', 'guifg=NONE', 'guibg=NONE', 'gui=inverse')
hi! link vCursor Cursor
hi! link iCursor Cursor
hi! link lCursor Cursor
" Gutter and Line Numbers
hi! link LineNr OuterSunset_fg_2
call Hi('CursorLineNr', 'guifg=' . s:colors.yellow[0], 'guibg=' . s:colors.bg[1])
" Folding
call Hi('Folded', 'guifg=' . s:colors.fg[1], 'guibg=' . s:colors.bg[1], 'gui=italic')
" Matched Paren
call Hi('MatchParen', 'guifg=NONE', 'guibg=' . s:colors.bg[2], 'gui=bold')
" Status Line
call Hi('StatusLine',   'guifg=' . s:colors.bg[0], 'guibg=' . s:colors.fg[0], 'gui=inverse')
call Hi('StatusLineNC', 'guifg=' . s:colors.bg[0], 'guibg=' . s:colors.fg[2], 'gui=inverse')


" Comment
hi! link Comment OuterSunset_fg_2

" KEYWORDS
" Generic statement
hi! link Statement OuterSunset_Important
" if, then, else, endif, swicth, etc.
hi! link Conditional OuterSunset_Important
" for, do, while, etc.
hi! link Repeat OuterSunset_Important
" case, default, etc.
hi! link Label OuterSunset_Important
" try, catch, throw
hi! link Exception OuterSunset_Important
" sizeof, "+", "*", etc.
hi! link Operator Normal
" Any other keyword
hi! link Keyword OuterSunset_Important

" NAMES
" Variable name
hi! link Identifier OuterSunset_blue_0
" Function name
hi! link Function OuterSunset_green_0_bold

" PREPROCESSOR
" Generic preprocessor
hi! link PreProc OuterSunset_Macro
" Preprocessor #include
hi! link Include OuterSunset_Macro
" Preprocessor #define
hi! link Define OuterSunset_Macro
" Same as Define
hi! link Macro OuterSunset_Macro
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit OuterSunset_Macro

" LITERALS
" Generic constant
hi! link Constant OuterSunset_Value
" Character constant: 'c', '/n'
hi! link Character OuterSunset_Value
" String constant: "this is a string"
hi! link String OuterSunset_yellow_0
" Boolean constant: TRUE, false
hi! link Boolean OuterSunset_Value
" Number constant: 234, 0xff
hi! link Number OuterSunset_Value
" Floating point constant: 2.3e10
hi! link Float OuterSunset_Value

" Generic type
hi! link Type OuterSunset_yellow_0
" static, register, volatile, etc
hi! link StorageClass OuterSunset_orange_0
" struct, union, enum, etc.
hi! link Structure OuterSunset_green_0
" typedef
hi! link Typedef OuterSunset_yellow_0


" ALE
call Hi('ALEError', 'gui=undercurl,', 'guisp=' . s:colors.red[0])
call Hi('ALEWarning', 'gui=undercurl,', 'guisp=' . s:colors.yellow[0])
call Hi('ALEInfo', 'gui=undercurl,', 'guisp=' . s:colors.blue[0])

hi! link ALEErrorSign OuterSunset_red_0_sign
hi! link ALEWarningSign OuterSunset_yellow_0_sign
hi! link ALEInfoSign OuterSunset_blue_0_sign


" TypeScript
hi! link typeScriptReserved OuterSunset_rose_0
hi! link typeScriptLabel OuterSunset_rose_0
hi! link typeScriptFuncKeyword OuterSunset_green_0
hi! link typeScriptIdentifier OuterSunset_orange_0
hi! link typeScriptBraces OuterSunset_fg_1
hi! link typeScriptEndColons OutserSunset_fg_1
hi! link typeScriptDOMObjects OuterSunset_fg_1
hi! link typeScriptAjaxMethods OuterSunset_fg_1
hi! link typeScriptLogicSymbols OuterSunset_fg_1
hi! link typeScriptDocSeeTag Comment
hi! link typeScriptDocParam Comment
hi! link typeScriptDocTags vimCommentTitle
hi! link typeScriptGlobalObjects OuterSunset_fg_1
hi! link typeScriptParens OuterSunset_fg_2
hi! link typeScriptOpSymbols OuterSunset_fg_2
hi! link typeScriptHtmlElemProperties OuterSunset_fg_2
hi! link typeScriptNull OuterSunset_Value
hi! link typeScriptInterpolationDelimiter OuterSunset_rose
