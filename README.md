# mistral.vim

A refined, complete **Mistral Vibe Dark** color scheme for **Vim** and **Neovim**.

Inspired by Mistral AI's brand identity and the official `mistral-vibe` CLI coding agent aesthetic, `mistral.vim` pairs deep carbon backgrounds with a warm sunset spectrum (yellow &rarr; amber &rarr; flame orange &rarr; red) and crisp, readable typography.

---

## Palette Highlights

| Tone | Hex | Role |
| :--- | :--- | :--- |
| **Void Black** | `#0f0f11` | Default editor background |
| **Dark Zinc** | `#18181b` | Soft background / CursorLine / Inactive tabs |
| **Elevated Slate** | `#202025` | Floats, popups, and visual selection |
| **Warm Snow** | `#fbfbf8` | Primary text and bright keywords |
| **Muted Zinc** | `#71717a` | Comments and line numbers |
| **Flame Orange** | `#fa520f` | Statements, keywords, tags, active borders |
| **Warm Orange** | `#ff8205` | Types, structures, operators |
| **Amber Gold** | `#ffaf00` | Constants, numbers, booleans |
| **Sunshine Gold** | `#ffd800` | Functions, methods, search matches |
| **Flame Red** | `#e10500` | Errors, exceptions, urgent alerts |
| **Emerald Green**| `#4ade80` | Strings, additions, success |
| **Ice Cyan** | `#38bdf8` | Preprocessor, includes, tech accents |

---

## Installation

### Vundle
```vim
Plugin 'konimarti/mistral.vim'
```

### vim-plug
```vim
Plug 'konimarti/mistral.vim'
```

### Packer (Neovim)
```lua
use 'konimarti/mistral.vim'
```

### Lazy.nvim (Neovim)
```lua
{
  'konimarti/mistral.vim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd('colorscheme mistral')
  end
}
```

---

## Configuration

Add the following to your `~/.vimrc` or `init.vim`:

```vim
" Enable true-color terminal support if available
if has('termguicolors')
  set termguicolors
endif

" Optional configurations (defaults shown):
let g:mistral_style = 'dark'                     " 'dark' (default) or 'soft'
let g:mistral_transparent_background = 0        " 1 to enable transparent background
let g:mistral_italic_comments = 1               " 1 for italic comments
let g:mistral_italic_keywords = 0               " 1 for italic keywords
let g:mistral_bold = 1                          " 1 for bold keywords / functions

" Load colorscheme
colorscheme mistral
```

---

## Statusline Support

### Lightline
```vim
let g:lightline = {
      \ 'colorscheme': 'mistral',
      \ }
```

### vim-airline
```vim
let g:airline_theme = 'mistral'
```

---

## Plugin Support

`mistral.vim` includes comprehensive out-of-the-box styling for:
- **Neovim Treesitter** (`@variable`, `@function`, `@keyword`, `@type`, `@punctuation`, etc.)
- **Neovim Built-in LSP & Diagnostics** (`DiagnosticError`, `DiagnosticWarn`, `DiagnosticUnderline*`, etc.)
- **ALE** (Asynchronous Lint Engine)
- **vim-lsp**
- **GitGutter**, **GitSigns**, and **vim-fugitive**
- **FZF** & **QuickScope**
- **NERDTree** & **Tagbar**
- **IndentLine**

---

## License

MIT License.
