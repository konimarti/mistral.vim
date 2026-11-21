" ==============================================================================
" Name:        autoload/airline/themes/mistral.vim
" Description: Mistral Vibe Dark theme for vim-airline
" License:     MIT
" ==============================================================================

let s:void_black    = '#0f0f11'
let s:carbon        = '#141417'
let s:surface       = '#18181b'
let s:slate         = '#202025'
let s:container     = '#27272f'
let s:muted         = '#71717a'
let s:secondary     = '#a1a1aa'
let s:text_light    = '#d4d4d8'
let s:snow          = '#f4f4f5'
let s:cream         = '#fbfbf8'
let s:flame_orange  = '#fa520f'
let s:warm_orange   = '#ff8205'
let s:amber_gold    = '#ffaf00'
let s:sunshine_gold = '#ffd800'
let s:flame_red     = '#e10500'

let g:airline#themes#mistral#palette = {}

function! airline#themes#mistral#refresh() abort
  let l:N1 = [ s:void_black, s:sunshine_gold, 16, 220 ]
  let l:N2 = [ s:cream, s:container, 231, 237 ]
  let l:N3 = [ s:secondary, s:carbon, 248, 234 ]
  let g:airline#themes#mistral#palette.normal = airline#themes#generate_color_map(l:N1, l:N2, l:N3)

  let l:I1 = [ s:cream, s:flame_orange, 231, 202 ]
  let l:I2 = [ s:cream, s:container, 231, 237 ]
  let l:I3 = [ s:cream, s:carbon, 231, 234 ]
  let g:airline#themes#mistral#palette.insert = airline#themes#generate_color_map(l:I1, l:I2, l:I3)

  let l:V1 = [ s:void_black, s:warm_orange, 16, 208 ]
  let l:V2 = [ s:cream, s:container, 231, 237 ]
  let l:V3 = [ s:cream, s:carbon, 231, 234 ]
  let g:airline#themes#mistral#palette.visual = airline#themes#generate_color_map(l:V1, l:V2, l:V3)

  let l:R1 = [ s:cream, s:flame_red, 231, 196 ]
  let l:R2 = [ s:cream, s:container, 231, 237 ]
  let l:R3 = [ s:cream, s:carbon, 231, 234 ]
  let g:airline#themes#mistral#palette.replace = airline#themes#generate_color_map(l:R1, l:R2, l:R3)

  let l:IA1 = [ s:muted, s:surface, 243, 235 ]
  let l:IA2 = [ s:muted, s:surface, 243, 235 ]
  let l:IA3 = [ s:muted, s:carbon, 243, 234 ]
  let g:airline#themes#mistral#palette.inactive = airline#themes#generate_color_map(l:IA1, l:IA2, l:IA3)

  let l:accents = {
        \ 'red': [ s:flame_red, '', 196, '' ]
        \ }
  let g:airline#themes#mistral#palette.accents = l:accents
endfunction

call airline#themes#mistral#refresh()
