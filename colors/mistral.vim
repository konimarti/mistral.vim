" ==============================================================================
" Name:        mistral.vim
" Description: A refined, complete Mistral Vibe Dark colorscheme for Vim & Neovim
" License:     MIT
" ==============================================================================

scriptencoding utf-8

" Clear existing highlighting
if exists('g:syntax_on')
  syntax reset
endif

set background=dark
let g:colors_name = 'mistral'

" ------------------------------------------------------------------------------
" User Configuration Options
" ------------------------------------------------------------------------------
let s:style = get(g:, 'mistral_style', 'dark')                    " 'dark' (default) or 'soft'
let s:transparent = get(g:, 'mistral_transparent_background', 0) " 1 to disable editor bg
let s:italic_comments = get(g:, 'mistral_italic_comments', 1)    " 1 for italic comments
let s:italic_keywords = get(g:, 'mistral_italic_keywords', 0)    " 1 for italic keywords
let s:bold = get(g:, 'mistral_bold', 1)                          " 1 to enable bold text

" ------------------------------------------------------------------------------
" Palette Definitions (GUI Hex & 256-Color cterm)
" ------------------------------------------------------------------------------
let s:p = {}

" Canvas / Surfaces
if s:style ==# 'soft'
  let s:p.bg_main        = ['#18181b', 235]  " dark zinc surface
  let s:p.bg_alt         = ['#202025', 236]  " elevated slate
else
  let s:p.bg_main        = ['#0f0f11', 16]   " deep void carbon
  let s:p.bg_alt         = ['#18181b', 235]  " carbon surface
endif

let s:p.bg_panel         = ['#141417', 234]  " panel / status line
let s:p.bg_card          = ['#202025', 236]  " card / floating window
let s:p.bg_highlight     = ['#27272f', 237]  " visual selection / active pill
let s:p.bg_line          = ['#18181b', 235]  " cursorline / colorcolumn
let s:p.border           = ['#33333b', 238]  " subtle border / vertsplit
let s:p.border_bright    = ['#3f3f46', 239]  " elevated border

" Foreground & Text Hierarchy
let s:p.fg_snow          = ['#fbfbf8', 231]  " primary crisp off-white / snow
let s:p.fg_main          = ['#f4f4f5', 255]  " normal readable text
let s:p.fg_light         = ['#d4d4d8', 252]  " identifiers & properties
let s:p.fg_secondary     = ['#a1a1aa', 248]  " punctuation & delimiters
let s:p.fg_muted         = ['#71717a', 243]  " comments, line numbers, subtle guides
let s:p.fg_dim           = ['#52525b', 240]  " non-text, end-of-buffer

" Mistral Signature Flame Ramp
let s:p.flame_orange     = ['#fa520f', 202]  " brand signature orange (keywords, statements)
let s:p.warm_orange      = ['#ff8205', 208]  " warm orange (types, operators, tags)
let s:p.amber_gold       = ['#ffaf00', 214]  " amber gold (constants, booleans, numbers)
let s:p.sunshine_gold    = ['#ffd800', 220]  " sunshine gold (functions, headings, search)
let s:p.parchment        = ['#fff8e0', 230]  " tactile parchment highlight
let s:p.flame_red        = ['#e10500', 196]  " critical red (errors, exceptions, deletes)

" Extended Accents & Diagnostics
let s:p.emerald_green    = ['#4ade80', 78]   " strings, additions, success
let s:p.soft_lime        = ['#86efac', 120]  " regex, escapes, characters
let s:p.ice_cyan         = ['#38bdf8', 81]   " preprocessor, includes, tech accent
let s:p.cool_teal        = ['#5eead4', 80]   " special chars, symbols
let s:p.soft_pink        = ['#f472b6', 211]  " special identifiers, decorators
let s:p.coral_warn       = ['#fb923c', 215]  " warnings, modified diff
let s:p.dark_red         = ['#3b1219', 52]   " diff delete bg
let s:p.dark_green       = ['#132c1c', 22]   " diff add bg
let s:p.dark_amber       = ['#382b13', 58]   " diff change bg

let s:p.none             = ['NONE', 'NONE']

" ------------------------------------------------------------------------------
" Highlight Helper Function
" ------------------------------------------------------------------------------
function! s:hi(group, fg, bg, attr, ...) abort
  let l:cmd = 'hi! ' . a:group

  if !empty(a:fg) && a:fg[0] !=# 'NONE'
    let l:cmd .= ' guifg=' . a:fg[0] . ' ctermfg=' . a:fg[1]
  elseif !empty(a:fg) && a:fg[0] ==# 'NONE'
    let l:cmd .= ' guifg=NONE ctermfg=NONE'
  endif

  if s:transparent && (a:group ==# 'Normal' || a:group ==# 'NonText' || a:group ==# 'SignColumn' || a:group ==# 'LineNr' || a:group ==# 'FoldColumn')
    let l:cmd .= ' guibg=NONE ctermbg=NONE'
  elseif !empty(a:bg) && a:bg[0] !=# 'NONE'
    let l:cmd .= ' guibg=' . a:bg[0] . ' ctermbg=' . a:bg[1]
  elseif !empty(a:bg) && a:bg[0] ==# 'NONE'
    let l:cmd .= ' guibg=NONE ctermbg=NONE'
  endif

  let l:attr = a:attr
  if !s:bold && l:attr =~# 'bold'
    let l:attr = substitute(l:attr, 'bold', '', 'g')
  endif
  if !s:italic_comments && a:group =~# 'Comment' && l:attr =~# 'italic'
    let l:attr = substitute(l:attr, 'italic', '', 'g')
  endif
  if !s:italic_keywords && (a:group =~# 'Statement' || a:group =~# 'Keyword') && l:attr =~# 'italic'
    let l:attr = substitute(l:attr, 'italic', '', 'g')
  endif

  let l:attr = substitute(l:attr, '^,\|,$', '', 'g')
  if empty(l:attr)
    let l:attr = 'NONE'
  endif

  let l:cmd .= ' gui=' . l:attr . ' cterm=' . l:attr

  if a:0 > 0 && !empty(a:1) && a:1[0] !=# 'NONE'
    let l:cmd .= ' guisp=' . a:1[0]
  endif

  execute l:cmd
endfunction

" ------------------------------------------------------------------------------
" Editor UI Highlighting
" ------------------------------------------------------------------------------
call s:hi('Normal',          s:p.fg_snow,       s:p.bg_main,      'NONE')
call s:hi('NormalFloat',     s:p.fg_snow,       s:p.bg_card,      'NONE')
call s:hi('FloatBorder',     s:p.border_bright, s:p.bg_card,      'NONE')
call s:hi('ColorColumn',     s:p.none,          s:p.bg_line,      'NONE')
call s:hi('Cursor',          s:p.bg_main,       s:p.sunshine_gold,'NONE')
call s:hi('CursorIM',        s:p.bg_main,       s:p.flame_orange, 'NONE')
call s:hi('CursorColumn',    s:p.none,          s:p.bg_line,      'NONE')
call s:hi('CursorLine',      s:p.none,          s:p.bg_line,      'NONE')
call s:hi('Directory',       s:p.ice_cyan,      s:p.none,         'bold')
call s:hi('DiffAdd',         s:p.emerald_green, s:p.dark_green,   'NONE')
call s:hi('DiffChange',      s:p.amber_gold,    s:p.dark_amber,   'NONE')
call s:hi('DiffDelete',      s:p.flame_red,     s:p.dark_red,     'bold')
call s:hi('DiffText',        s:p.fg_snow,       s:p.amber_gold,   'bold')
call s:hi('EndOfBuffer',     s:p.fg_dim,        s:p.none,         'NONE')
call s:hi('ErrorMsg',        s:p.flame_red,     s:p.none,         'bold')
call s:hi('VertSplit',       s:p.border,        s:p.bg_main,      'NONE')
call s:hi('WinSeparator',    s:p.border,        s:p.bg_main,      'NONE')
call s:hi('Folded',          s:p.fg_muted,      s:p.bg_line,      'NONE')
call s:hi('FoldColumn',      s:p.fg_muted,      s:p.bg_main,      'NONE')
call s:hi('SignColumn',      s:p.fg_muted,      s:p.bg_main,      'NONE')
call s:hi('IncSearch',       s:p.bg_main,       s:p.flame_orange, 'bold')
call s:hi('CurSearch',       s:p.bg_main,       s:p.flame_orange, 'bold')
call s:hi('LineNr',          s:p.fg_muted,      s:p.bg_main,      'NONE')
call s:hi('CursorLineNr',    s:p.sunshine_gold, s:p.bg_line,      'bold')
call s:hi('MatchParen',      s:p.sunshine_gold, s:p.bg_highlight, 'bold,underline')
call s:hi('ModeMsg',         s:p.sunshine_gold, s:p.none,         'bold')
call s:hi('MoreMsg',         s:p.emerald_green, s:p.none,         'bold')
call s:hi('NonText',         s:p.fg_dim,        s:p.none,         'NONE')
call s:hi('Pmenu',           s:p.fg_main,       s:p.bg_card,      'NONE')
call s:hi('PmenuSel',        s:p.bg_main,       s:p.sunshine_gold,'bold')
call s:hi('PmenuSbar',       s:p.none,          s:p.bg_highlight, 'NONE')
call s:hi('PmenuThumb',      s:p.none,          s:p.sunshine_gold,'NONE')
call s:hi('Question',        s:p.emerald_green, s:p.none,         'bold')
call s:hi('QuickFixLine',    s:p.none,          s:p.bg_highlight, 'bold')
call s:hi('Search',          s:p.bg_main,       s:p.sunshine_gold,'bold')
call s:hi('SpecialKey',      s:p.fg_dim,        s:p.none,         'NONE')
call s:hi('SpellBad',        s:p.flame_red,     s:p.none,         'undercurl', s:p.flame_red)
call s:hi('SpellCap',        s:p.amber_gold,    s:p.none,         'undercurl', s:p.amber_gold)
call s:hi('SpellLocal',      s:p.ice_cyan,      s:p.none,         'undercurl', s:p.ice_cyan)
call s:hi('SpellRare',       s:p.soft_pink,     s:p.none,         'undercurl', s:p.soft_pink)
call s:hi('StatusLine',      s:p.fg_snow,       s:p.bg_highlight, 'bold')
call s:hi('StatusLineNC',    s:p.fg_muted,      s:p.bg_panel,     'NONE')
call s:hi('StatusLineTerm',  s:p.fg_snow,       s:p.bg_highlight, 'bold')
call s:hi('StatusLineTermNC',s:p.fg_muted,      s:p.bg_panel,     'NONE')
call s:hi('TabLine',         s:p.fg_muted,      s:p.bg_panel,     'NONE')
call s:hi('TabLineFill',     s:p.none,          s:p.bg_panel,     'NONE')
call s:hi('TabLineSel',      s:p.fg_snow,       s:p.bg_highlight, 'bold')
call s:hi('Title',           s:p.sunshine_gold, s:p.none,         'bold')
call s:hi('Visual',          s:p.fg_snow,       s:p.bg_highlight, 'NONE')
call s:hi('VisualNOS',       s:p.fg_snow,       s:p.bg_highlight, 'NONE')
call s:hi('WarningMsg',      s:p.coral_warn,    s:p.none,         'bold')
call s:hi('WildMenu',        s:p.bg_main,       s:p.sunshine_gold,'bold')

" ------------------------------------------------------------------------------
" Standard Generic Syntax Highlighting
" ------------------------------------------------------------------------------
call s:hi('Comment',         s:p.fg_muted,      s:p.none,         'italic')

call s:hi('Constant',        s:p.amber_gold,    s:p.none,         'NONE')
call s:hi('String',          s:p.emerald_green, s:p.none,         'NONE')
call s:hi('Character',       s:p.soft_lime,     s:p.none,         'NONE')
call s:hi('Number',          s:p.amber_gold,    s:p.none,         'NONE')
call s:hi('Boolean',         s:p.amber_gold,    s:p.none,         'bold')
call s:hi('Float',           s:p.amber_gold,    s:p.none,         'NONE')

call s:hi('Identifier',      s:p.fg_light,      s:p.none,         'NONE')
call s:hi('Function',        s:p.sunshine_gold, s:p.none,         'bold')

call s:hi('Statement',       s:p.flame_orange,  s:p.none,         'bold')
call s:hi('Conditional',     s:p.flame_orange,  s:p.none,         'bold')
call s:hi('Repeat',          s:p.flame_orange,  s:p.none,         'bold')
call s:hi('Label',           s:p.flame_orange,  s:p.none,         'NONE')
call s:hi('Operator',        s:p.warm_orange,   s:p.none,         'NONE')
call s:hi('Keyword',         s:p.flame_orange,  s:p.none,         'bold')
call s:hi('Exception',       s:p.flame_red,     s:p.none,         'bold')

call s:hi('PreProc',         s:p.ice_cyan,      s:p.none,         'NONE')
call s:hi('Include',         s:p.flame_orange,  s:p.none,         'bold')
call s:hi('Define',          s:p.ice_cyan,      s:p.none,         'NONE')
call s:hi('Macro',           s:p.ice_cyan,      s:p.none,         'bold')
call s:hi('PreCondit',       s:p.ice_cyan,      s:p.none,         'NONE')

call s:hi('Type',            s:p.warm_orange,   s:p.none,         'bold')
call s:hi('StorageClass',    s:p.flame_orange,  s:p.none,         'NONE')
call s:hi('Structure',       s:p.warm_orange,   s:p.none,         'bold')
call s:hi('Typedef',         s:p.warm_orange,   s:p.none,         'bold')

call s:hi('Special',         s:p.cool_teal,     s:p.none,         'NONE')
call s:hi('SpecialChar',     s:p.soft_lime,     s:p.none,         'bold')
call s:hi('Tag',             s:p.flame_orange,  s:p.none,         'NONE')
call s:hi('Delimiter',       s:p.fg_secondary,  s:p.none,         'NONE')
call s:hi('SpecialComment',  s:p.fg_secondary,  s:p.none,         'bold,italic')
call s:hi('Debug',           s:p.flame_red,     s:p.none,         'bold')

call s:hi('Underlined',      s:p.ice_cyan,      s:p.none,         'underline')
call s:hi('Ignore',          s:p.fg_dim,        s:p.none,         'NONE')
call s:hi('Error',           s:p.fg_snow,       s:p.flame_red,    'bold')
call s:hi('Todo',            s:p.bg_main,       s:p.sunshine_gold,'bold')

" ------------------------------------------------------------------------------
" Filetype-Specific Syntax Highlights
" ------------------------------------------------------------------------------
" Markdown
call s:hi('markdownH1',                 s:p.sunshine_gold, s:p.none, 'bold')
call s:hi('markdownH2',                 s:p.flame_orange,  s:p.none, 'bold')
call s:hi('markdownH3',                 s:p.warm_orange,   s:p.none, 'bold')
call s:hi('markdownH4',                 s:p.amber_gold,    s:p.none, 'bold')
call s:hi('markdownH5',                 s:p.ice_cyan,      s:p.none, 'bold')
call s:hi('markdownH6',                 s:p.fg_muted,      s:p.none, 'bold')
call s:hi('markdownCode',               s:p.emerald_green, s:p.none, 'NONE')
call s:hi('markdownCodeBlock',          s:p.fg_main,       s:p.none, 'NONE')
call s:hi('markdownLinkText',           s:p.ice_cyan,      s:p.none, 'underline')
call s:hi('markdownUrl',                s:p.fg_muted,      s:p.none, 'underline')
call s:hi('markdownRule',               s:p.border_bright, s:p.none, 'bold')

" HTML / XML
call s:hi('htmlTag',                    s:p.fg_secondary,  s:p.none, 'NONE')
call s:hi('htmlEndTag',                 s:p.fg_secondary,  s:p.none, 'NONE')
call s:hi('htmlTagName',                s:p.flame_orange,  s:p.none, 'bold')
call s:hi('htmlArg',                    s:p.sunshine_gold, s:p.none, 'NONE')
call s:hi('htmlSpecialTagName',         s:p.flame_orange,  s:p.none, 'bold')

" JSON / YAML / TOML
call s:hi('jsonKeyword',                s:p.sunshine_gold, s:p.none, 'NONE')
call s:hi('jsonString',                 s:p.emerald_green, s:p.none, 'NONE')
call s:hi('yamlKey',                    s:p.sunshine_gold, s:p.none, 'NONE')
call s:hi('tomlKey',                    s:p.sunshine_gold, s:p.none, 'NONE')
call s:hi('tomlTable',                  s:p.flame_orange,  s:p.none, 'bold')

" Shell / Bash
call s:hi('shVariable',                 s:p.fg_light,      s:p.none, 'NONE')
call s:hi('shDerefSimple',              s:p.amber_gold,    s:p.none, 'NONE')
call s:hi('shFunction',                 s:p.sunshine_gold, s:p.none, 'bold')

" C / C3 / Rust / Go
call s:hi('cType',                      s:p.warm_orange,   s:p.none, 'bold')
call s:hi('cStructure',                 s:p.warm_orange,   s:p.none, 'bold')
call s:hi('cStorageClass',              s:p.flame_orange,  s:p.none, 'NONE')
call s:hi('rustModPath',                s:p.ice_cyan,      s:p.none, 'NONE')
call s:hi('rustMacro',                  s:p.ice_cyan,      s:p.none, 'bold')
call s:hi('goPackage',                  s:p.flame_orange,  s:p.none, 'bold')
call s:hi('goImport',                   s:p.flame_orange,  s:p.none, 'bold')

" ------------------------------------------------------------------------------
" Diagnostic, LSP & Linting Highlights
" ------------------------------------------------------------------------------
call s:hi('DiagnosticError',            s:p.flame_red,     s:p.none, 'NONE')
call s:hi('DiagnosticWarn',             s:p.coral_warn,    s:p.none, 'NONE')
call s:hi('DiagnosticInfo',             s:p.ice_cyan,      s:p.none, 'NONE')
call s:hi('DiagnosticHint',             s:p.cool_teal,     s:p.none, 'NONE')

call s:hi('DiagnosticUnderlineError',   s:p.none,          s:p.none, 'undercurl', s:p.flame_red)
call s:hi('DiagnosticUnderlineWarn',    s:p.none,          s:p.none, 'undercurl', s:p.coral_warn)
call s:hi('DiagnosticUnderlineInfo',    s:p.none,          s:p.none, 'undercurl', s:p.ice_cyan)
call s:hi('DiagnosticUnderlineHint',    s:p.none,          s:p.none, 'undercurl', s:p.cool_teal)

" ALE Highlights
call s:hi('ALEError',                   s:p.none,          s:p.none, 'undercurl', s:p.flame_red)
call s:hi('ALEWarning',                 s:p.none,          s:p.none, 'undercurl', s:p.coral_warn)
call s:hi('ALEInfo',                    s:p.none,          s:p.none, 'undercurl', s:p.ice_cyan)
call s:hi('ALEErrorSign',               s:p.flame_red,     s:p.bg_main, 'bold')
call s:hi('ALEWarningSign',             s:p.coral_warn,    s:p.bg_main, 'bold')
call s:hi('ALEInfoSign',                s:p.ice_cyan,      s:p.bg_main, 'NONE')

" vim-lsp Highlights
call s:hi('LspErrorText',               s:p.flame_red,     s:p.bg_main, 'bold')
call s:hi('LspWarningText',             s:p.coral_warn,    s:p.bg_main, 'bold')
call s:hi('LspInformationText',         s:p.ice_cyan,      s:p.bg_main, 'NONE')
call s:hi('LspHintText',                s:p.cool_teal,     s:p.bg_main, 'NONE')
call s:hi('LspErrorHighlight',          s:p.none,          s:p.none,    'undercurl', s:p.flame_red)
call s:hi('LspWarningHighlight',        s:p.none,          s:p.none,    'undercurl', s:p.coral_warn)
call s:hi('LspInformationHighlight',    s:p.none,          s:p.none,    'undercurl', s:p.ice_cyan)
call s:hi('LspHintHighlight',           s:p.none,          s:p.none,    'undercurl', s:p.cool_teal)

" ------------------------------------------------------------------------------
" Git & Version Control Plugins
" ------------------------------------------------------------------------------
" GitGutter
call s:hi('GitGutterAdd',               s:p.emerald_green, s:p.bg_main, 'bold')
call s:hi('GitGutterChange',            s:p.amber_gold,    s:p.bg_main, 'bold')
call s:hi('GitGutterDelete',            s:p.flame_red,     s:p.bg_main, 'bold')
call s:hi('GitGutterChangeDelete',      s:p.coral_warn,    s:p.bg_main, 'bold')

" GitSigns (Neovim)
call s:hi('GitSignsAdd',                s:p.emerald_green, s:p.bg_main, 'NONE')
call s:hi('GitSignsChange',             s:p.amber_gold,    s:p.bg_main, 'NONE')
call s:hi('GitSignsDelete',             s:p.flame_red,     s:p.bg_main, 'NONE')

" Fugitive
call s:hi('diffAdded',                  s:p.emerald_green, s:p.none,    'NONE')
call s:hi('diffRemoved',                s:p.flame_red,     s:p.none,    'NONE')
call s:hi('diffFile',                   s:p.sunshine_gold, s:p.none,    'bold')
call s:hi('diffNewFile',                s:p.emerald_green, s:p.none,    'bold')
call s:hi('diffLine',                   s:p.ice_cyan,      s:p.none,    'NONE')

" ------------------------------------------------------------------------------
" Plugin Integrations (FZF, QuickScope, Tagbar, IndentLine, etc.)
" ------------------------------------------------------------------------------
" QuickScope
call s:hi('QuickScopePrimary',          s:p.sunshine_gold, s:p.none,    'bold,underline')
call s:hi('QuickScopeSecondary',        s:p.flame_orange,  s:p.none,    'bold,underline')

" IndentLine
call s:hi('IndentLine',                 s:p.border,        s:p.none,    'NONE')
call s:hi('IndentLineChar',             s:p.border,        s:p.none,    'NONE')

" Tagbar
call s:hi('TagbarHighlight',            s:p.sunshine_gold, s:p.bg_highlight, 'bold')
call s:hi('TagbarVisibilityPublic',     s:p.emerald_green, s:p.none,         'NONE')
call s:hi('TagbarVisibilityProtected',  s:p.amber_gold,    s:p.none,         'NONE')
call s:hi('TagbarVisibilityPrivate',    s:p.flame_red,     s:p.none,         'NONE')

" NERDTree & File Browsers
call s:hi('NERDTreeDir',                s:p.ice_cyan,      s:p.none,    'bold')
call s:hi('NERDTreeDirSlash',           s:p.fg_secondary,  s:p.none,    'NONE')
call s:hi('NERDTreeOpenable',           s:p.flame_orange,  s:p.none,    'bold')
call s:hi('NERDTreeClosable',           s:p.sunshine_gold, s:p.none,    'bold')
call s:hi('NERDTreeFile',               s:p.fg_main,       s:p.none,    'NONE')
call s:hi('NERDTreeExecFile',           s:p.emerald_green, s:p.none,    'bold')
call s:hi('NERDTreeUp',                 s:p.fg_muted,      s:p.none,    'NONE')
call s:hi('NERDTreeCWD',                s:p.sunshine_gold, s:p.none,    'bold')

" ------------------------------------------------------------------------------
" Neovim Treesitter Highlights (Link & Define)
" ------------------------------------------------------------------------------
if has('nvim')
  hi! link @variable                Identifier
  hi! link @variable.builtin        Special
  hi! link @variable.parameter      Identifier
  hi! link @variable.member         Identifier

  hi! link @constant                Constant
  hi! link @constant.builtin        Boolean
  hi! link @constant.macro          Define

  hi! link @string                  String
  hi! link @string.regex            Character
  hi! link @string.escape           SpecialChar
  hi! link @character               Character
  hi! link @number                  Number
  hi! link @boolean                 Boolean
  hi! link @float                   Float

  hi! link @function                Function
  hi! link @function.builtin        Special
  hi! link @function.macro          Macro
  hi! link @function.method         Function
  hi! link @constructor             Structure

  hi! link @keyword                 Keyword
  hi! link @keyword.function        Keyword
  hi! link @keyword.operator        Operator
  hi! link @keyword.return          Statement
  hi! link @conditional             Conditional
  hi! link @repeat                  Repeat
  hi! link @label                   Label
  hi! link @operator                Operator
  hi! link @exception               Exception

  hi! link @type                    Type
  hi! link @type.builtin            Type
  hi! link @type.definition         Typedef

  hi! link @punctuation.delimiter   Delimiter
  hi! link @punctuation.bracket     Delimiter
  hi! link @punctuation.special     Special
  hi! link @comment                 Comment
  hi! link @tag                     Tag
  hi! link @tag.attribute           htmlArg
  hi! link @tag.delimiter           Delimiter
endif
