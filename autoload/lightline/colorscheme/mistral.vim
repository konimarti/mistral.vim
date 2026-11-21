" ==============================================================================
" Name:        autoload/lightline/colorscheme/mistral.vim
" Description: Mistral Vibe Dark theme for lightline.vim
" License:     MIT
" ==============================================================================

let s:void_black    = [ '#0f0f11', 16  ]
let s:carbon        = [ '#141417', 234 ]
let s:surface       = [ '#18181b', 235 ]
let s:slate         = [ '#202025', 236 ]
let s:container     = [ '#27272f', 237 ]
let s:border        = [ '#33333b', 238 ]
let s:muted         = [ '#71717a', 243 ]
let s:secondary     = [ '#a1a1aa', 248 ]
let s:text_light    = [ '#d4d4d8', 252 ]
let s:snow          = [ '#f4f4f5', 255 ]
let s:cream         = [ '#fbfbf8', 231 ]
let s:flame_orange  = [ '#fa520f', 202 ]
let s:warm_orange   = [ '#ff8205', 208 ]
let s:amber_gold    = [ '#ffaf00', 214 ]
let s:sunshine_gold = [ '#ffd800', 220 ]
let s:flame_red     = [ '#e10500', 196 ]
let s:emerald_green = [ '#4ade80', 78  ]
let s:ice_cyan      = [ '#38bdf8', 81  ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

" Left segments: Mode, Secondary Info, Filename
let s:p.normal.left   = [ [ s:void_black, s:sunshine_gold, 'bold' ], [ s:cream, s:container ], [ s:text_light, s:slate ] ]
let s:p.insert.left   = [ [ s:cream, s:flame_orange, 'bold' ],       [ s:cream, s:container ], [ s:text_light, s:slate ] ]
let s:p.visual.left   = [ [ s:void_black, s:warm_orange, 'bold' ],   [ s:cream, s:container ], [ s:text_light, s:slate ] ]
let s:p.replace.left  = [ [ s:cream, s:flame_red, 'bold' ],          [ s:cream, s:container ], [ s:text_light, s:slate ] ]

" Middle bar
let s:p.normal.middle = [ [ s:secondary, s:carbon ] ]
let s:p.insert.middle = [ [ s:cream, s:carbon ] ]
let s:p.visual.middle = [ [ s:cream, s:carbon ] ]
let s:p.replace.middle= [ [ s:cream, s:carbon ] ]

" Right segments
let s:p.normal.right  = [ [ s:void_black, s:amber_gold, 'bold' ],    [ s:cream, s:container ], [ s:muted, s:slate ] ]
let s:p.insert.right  = [ [ s:cream, s:flame_orange, 'bold' ],       [ s:cream, s:container ], [ s:muted, s:slate ] ]
let s:p.visual.right  = [ [ s:void_black, s:warm_orange, 'bold' ],   [ s:cream, s:container ], [ s:muted, s:slate ] ]
let s:p.replace.right = [ [ s:cream, s:flame_red, 'bold' ],          [ s:cream, s:container ], [ s:muted, s:slate ] ]

" Inactive windows
let s:p.inactive.left   = [ [ s:muted, s:surface ], [ s:muted, s:surface ] ]
let s:p.inactive.middle = [ [ s:muted, s:carbon ] ]
let s:p.inactive.right  = [ [ s:muted, s:surface ], [ s:muted, s:surface ] ]

" Tabs
let s:p.tabline.left    = [ [ s:muted, s:surface ] ]
let s:p.tabline.tabsel  = [ [ s:cream, s:container, 'bold' ] ]
let s:p.tabline.middle  = [ [ s:muted, s:carbon ] ]
let s:p.tabline.right   = [ [ s:void_black, s:sunshine_gold ] ]

" Linter errors / warnings
let s:p.normal.error   = [ [ s:cream, s:flame_red, 'bold' ] ]
let s:p.normal.warning = [ [ s:void_black, s:amber_gold, 'bold' ] ]

if exists('*lightline#colorscheme#flatten')
  let g:lightline#colorscheme#mistral#palette = lightline#colorscheme#flatten(s:p)
else
  let g:lightline#colorscheme#mistral#palette = s:p
endif
