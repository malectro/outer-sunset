let g:colors_name='outer sunset'
let s:group_prefix='OuterSunset'

" set color variables
" [light, dark]
let s:colors = #{
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
" Arguments name: group name, options...
function! Hi(name, ...)
  let histring = ['hi', s:group_prefix . '_' . a:name] + a:000
  execute join(histring, ' ')
endfunction

function! LocalGroup(name)
  s:group_prefix . '_' . name
endfunction

" create color groups
for [name, color] in items(s:colors)
  call Hi(name, 'guifg=' . color[0])
  for style in ['bold', 'italic']
    call Hi(name . '_' . style, 'guifg=' . color[0], 'gui=' . style)
  endfor
endfor

" local generalizations
hi! link OuterSunset_Important OuterSunset_red
hi! link OuterSunset_Macros OuterSunset_rose

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

" Variable name
hi! link Identifier OuterSunset_blue
" Function name
hi! link Function OuterSunset_green_bold

" Generic preprocessor
hi! link PreProc OuterSunset_Macros
" Preprocessor #include
hi! link Include OuterSunset_Macros
" Preprocessor #define
hi! link Define OuterSunset_Macros
" Same as Define
hi! link Macro OuterSunset_Macros
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit OuterSunset_Macros

" Generic constant
hi! link Constant OuterSunset_purple
" Character constant: 'c', '/n'
hi! link Character OuterSunset_purple
" String constant: "this is a string"
hi! link String OuterSunset_yellow
" Boolean constant: TRUE, false
hi! link Boolean OuterSunset_purple
" Number constant: 234, 0xff
hi! link Number OuterSunset_purple
" Floating point constant: 2.3e10
hi! link Float OuterSunset_purple

" Generic type
hi! link Type OuterSunset_yellow
" static, register, volatile, etc
hi! link StorageClass OuterSunset_orange
" struct, union, enum, etc.
hi! link Structure OuterSunset_green
" typedef
hi! link Typedef OuterSunset_yellow
