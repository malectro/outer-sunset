highlight clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

let g:colors_name='OuterSunset'
let s:group_prefix='OuterSunset'

" set color variables
" [light, dark]
let s:colors = outersunset#GetColors()

let s:something = s:colors.fg[1].gui

if !exists("g:outersunset_termcolors")
  let g:outersunset_termcolors = 256
endif

" Not all terminals support italics properly. If yours does, opt-in.
if !exists("g:outersunset_terminal_italics")
  let g:outersunset_terminal_italics = 1
endif


" This function is based on one from onedark: https://github.com/joshdick/onedark.vim
let s:group_colors = {} " Cache of default highlight group settings, for later reference via `onedark#extend_highlight`
function! s:h(group, style, ...)
  if (a:0 > 0) " Will be true if we got here from onedark#extend_highlight
    let s:highlight = s:group_colors[a:group]
    for style_type in ["fg", "bg", "sp"]
      if (has_key(a:style, style_type))
        let l:default_style = (has_key(s:highlight, style_type) ? s:highlight[style_type] : { "cterm16": "NONE", "cterm": "NONE", "gui": "NONE" })
        let s:highlight[style_type] = extend(l:default_style, a:style[style_type])
      endif
    endfor
    if (has_key(a:style, "gui"))
      let s:highlight.gui = a:style.gui
    endif
  else
    let s:highlight = a:style
    let s:group_colors[a:group] = s:highlight " Cache default highlight group settings
  endif

  if g:outersunset_terminal_italics == 0
    if has_key(s:highlight, "cterm") && s:highlight["cterm"] == "italic"
      unlet s:highlight.cterm
    endif
    if has_key(s:highlight, "gui") && s:highlight["gui"] == "italic"
      unlet s:highlight.gui
    endif
  endif

  let l:ctermfg = (has_key(s:highlight, "fg") ? s:highlight.fg.cterm.ctermfg : "NONE")
  let l:ctermbg = (has_key(s:highlight, "bg") ? s:highlight.bg.cterm.ctermfg : "NONE")

  execute "highlight" a:group
    \ "guifg="   (has_key(s:highlight, "fg")    ? s:highlight.fg.gui   : "NONE")
    \ "guibg="   (has_key(s:highlight, "bg")    ? s:highlight.bg.gui   : "NONE")
    \ "guisp="   (has_key(s:highlight, "sp")    ? s:highlight.sp.gui   : "NONE")
    \ "gui="     (has_key(s:highlight, "gui")   ? s:highlight.gui      : "NONE")
    \ "ctermfg=" . l:ctermfg
    \ "ctermbg=" . l:ctermbg
    \ "cterm="   (has_key(s:highlight, "cterm") ? s:highlight.cterm    : "NONE")
endfunction


" helper functions
function! Hi(name, ...)
  let histring = ['hi!', a:name] + a:000
  execute join(histring, ' ')
endfunction

" Arguments name: group name, options...
function! HiNamespace(name, ...)
  call call('s:h', [s:group_prefix . '_' . a:name] + a:000)
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
    let something = color.gui
    call HiNamespace(name . '_' . i, {'fg': color})
    for style in ['bold', 'italic']
      call HiNamespace(name . '_' . i . '_' . style, {'fg': color, 'gui': style})
    endfor
    call HiNamespace(name . '_' . i . '_sign', {'fg' : color, 'bg' : s:colors.bg[1], 'gui': 'inverse'})
    let i += 1
  endfor
endfor

" local generalizations
hi! link OuterSunset_Important OuterSunset_red_0
hi! link OuterSunset_Macro OuterSunset_rose_0
hi! link OuterSunset_Value OuterSunset_purple_0

" UI
" Background
call s:h('Normal', {'fg': s:colors.fg[0], 'bg': s:colors.bg[0]})
hi! link NonText OuterSunset_bg_0
hi! link SpecialKey OuterSunset_bg_0
" Cursor
call s:h('CursorLine', {'bg' : s:colors.bg[1]})
hi! link CursorColumn CursorLine
call s:h('Cursor', {'gui': 'inverse'})
hi! link vCursor Cursor
hi! link iCursor Cursor
hi! link lCursor Cursor
" Gutter and Line Numbers
hi! link LineNr OuterSunset_fg_2
call s:h('CursorLineNr', {'fg': s:colors.yellow[0], 'bg': s:colors.bg[1]})
" Tab Bar
call s:h('TabLineFill', {'bg': s:colors.fg[1]})
call s:h('TabLine', {'bg': s:colors.bg[2]})
hi! link TabLineSel Normal
hi! link Title OuterSunset_purple_0
" Folding
call s:h('Folded', {'fg': s:colors.fg[1], 'bg': s:colors.bg[1], 'gui': 'italic'})
" Matched Paren
call s:h('MatchParen', {'bg': s:colors.bg[2], 'gui': 'bold'})
" Status Line
call s:h('StatusLine', {'fg': s:colors.bg[0], 'bg': s:colors.fg[0], 'gui': 'inverse'})
call s:h('StatusLineNC', {'fg': s:colors.bg[0], 'bg': s:colors.fg[2], 'gui': 'inverse'})
" Search
hi! link Search OuterSunset_yellow_1_sign
" Popup Menu
call s:h("Pmenu", { "fg": s:colors.fg[0], "bg": s:colors.bg[1] }) " Popup menu: normal item.
" call s:h("PmenuSel", { "fg": s:cursor_grey, "bg": s:blue }) " Popup menu: selected item.
" call s:h("PmenuSbar", { "bg": s:cursor_grey }) " Popup menu: scrollbar.
" call s:h("PmenuThumb", { "bg": s:white }) " Popup menu: Thumb of the scrollbar.

" Comment
hi! link Comment OuterSunset_fg_2

" KEYWORDS
" Generic statement
hi! link Statement OuterSunset_fg_0
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
hi! link Special OuterSunset_Important

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

" GUI
call s:h('ErrorHighlight', {'gui': 'undercurl', 'sp': s:colors.red[0]})
call s:h('WarningHighlight', {'gui': 'undercurl', 'sp': s:colors.yellow[0]})
call s:h('InfoHighlight', {'gui': 'undercurl', 'sp': s:colors.blue[0]})
call s:h('HintHighlight', {'gui': 'undercurl', 'sp': s:colors.green[0]})

hi! link ErrorSign OuterSunset_red_0_sign
hi! link WarningSign OuterSunset_yellow_0_sign
hi! link InfoSign OuterSunset_blue_0_sign

" ALE
hi! link ALEError ErrorHighlight
hi! link ALEWarning WarningHighlight
hi! link ALEInfo InfoHighlight
" call s:h('ALEError', {'gui': 'undercurl', 'sp': s:colors.red[0]})
" call s:h('ALEWarning', {'gui': 'undercurl', 'sp': s:colors.yellow[0]})
" call s:h('ALEInfo', {'gui': 'undercurl', 'sp': s:colors.blue[0]})

" hi! link ALEErrorSign OuterSunset_red_0_sign
" hi! link ALEWarningSign OuterSunset_yellow_0_sign
" hi! link ALEInfoSign OuterSunset_blue_0_sign
hi! link ALEErrorSign ErrorSign
hi! link ALEWarningSign WarningSign
hi! link ALEInfoSign InfoSign


" CoC
hi! link CocErrorSign ErrorSign
hi! link CocWarningSign WarningSign
hi! link CocInfoSign InfoSign
hi! link CocHintSign OuterSunset_green_0_sign
hi! link CocErrorFloat OuterSunset_red_0
hi! link CocWarningFloat OuterSunset_yellow_0
hi! link CocInfoFloat OuterSunset_blue_0
hi! link CocHintFloat OuterSunset_green_0
call s:h('CocFloating', {'bg': s:colors.bg[1]})
hi! link CocDiagnosticsError OuterSunset_red_0
hi! link CocDiagnosticsWarning OuterSunset_yellow_0
hi! link CocDiagnosticsInfo OuterSunset_blue_0
hi! link CocDiagnosticsHint OuterSunset_green_0

hi! link CocSelectedText OuterSunset_red_0
hi! link CocCodeLens OuterSunset_bg_1

hi! link CocErrorHighlight ErrorHighlight
hi! link CocWarningHighlight WarningHighlight
hi! link CocInfoHighlight InfoHighlight
hi! link CocHintHighlight HintHighlight

" call s:HL('CocErrorHighlight', s:none, s:none, s:undercurl, s:red)
" call s:HL('CocWarningHighlight', s:none, s:none, s:undercurl, s:orange)
" call s:HL('CocInfoHighlight', s:none, s:none, s:undercurl, s:yellow)
" call s:HL('CocHintHighlight', s:none, s:none, s:undercurl, s:blue)


" JavaScript
hi! link jsBraces OuterSunset_fg_1
hi! link jsParens OuterSunset_fg_2
hi! link jsFunctionKey OuterSunset_green_0
hi! link jsFuncParens OuterSunset_green_0
hi! link jsFuncBraces OuterSunset_green_0
hi! link jsCommentTodo OuterSunset_yellow_0_bold
" call s:h('jsCommentTodo', {'bg': s:colors.yellow[1]})
" hi! link jsFuncCall OuterSunset_green_0
" hi! link jsObjectBraces OuterSunset_orange_0

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
hi! link typeScriptCommentTodo vimCommentTitle
hi! link typeScriptGlobalObjects OuterSunset_fg_1
hi! link typeScriptParens OuterSunset_fg_2
hi! link typeScriptOpSymbols OuterSunset_fg_2
hi! link typeScriptHtmlElemProperties OuterSunset_fg_2
hi! link typeScriptNull OuterSunset_Value
hi! link typeScriptInterpolationDelimiter OuterSunset_rose

" Treesitter
hi! link TSVariable OuterSunset_fg_0
hi! link TSConstructor OuterSunset_green_0
hi! link TSTag OuterSunset_fg_0
hi! link TSTagDelimiter OuterSunset_fg_1
hi! link TSPunctBracket OuterSunset_fg_2

" TreesitterTSX
" hi! link 
