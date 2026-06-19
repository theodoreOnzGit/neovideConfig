# 2026 Neovim config

A modern, plain-Neovim config (no Neovide) built on
[lazy.nvim](https://github.com/folke/lazy.nvim). The leader key is **Space**.

## Requirements

- **Neovim 0.11+** (uses native `vim.lsp.enable`; developed on 0.12).
- **git** — lazy.nvim bootstraps itself by cloning on first launch.
- A **Nerd Font** in your terminal for file/symbol icons.
- **rustup/cargo** on the system for `rust_analyzer` to work.
- **make** (optional) — builds luasnip's `jsregexp` for snippet transforms.

## Layout

```
init.lua                  # entry point: requires the modules below
lua/settings.lua          # editor options, spell, colorscheme background
lua/plugins.lua           # lazy.nvim bootstrap + plugin declarations
lua/lsp.lua               # mason servers + blink.cmp completion
lua/telescope_harpoon.lua # fuzzy finder + harpoon keymaps
spell/                    # custom spell dictionary
```

---

## Keymap quick reference

Leader = **Space**. Keymaps that this config binds explicitly:

### Fuzzy finding (telescope)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fb` | List open buffers |
| `<leader>fh` | Search help tags |

### File marks (harpoon)

| Key | Action |
|-----|--------|
| `<leader>b` | Add current file to harpoon |
| `<leader><Esc>` | Toggle the harpoon quick menu |
| `<leader>q` | Browse harpoon marks in telescope |

### Completion popup (blink.cmp)

These fire only while the completion menu is visible:

| Key | Action |
|-----|--------|
| `<CR>` | Confirm the selected item |
| `<C-Space>` | Trigger completion / toggle docs |
| `<C-e>` | Dismiss the menu |
| `<C-b>` / `<C-f>` | Scroll the documentation up / down |
| `<Tab>` / `<S-Tab>` | Jump to next / previous snippet placeholder |

### Custom keymaps (bound by this config)

Defined in `lua/keymaps.lua` (leader = Space):

| Key | Action |
|-----|--------|
| `<leader>gd` | LSP go to definition (cross-file, `vim.lsp.buf.definition`) |
| `<leader>gr` | LSP go to references (`vim.lsp.buf.references`) |
| `<leader>rn` | LSP rename symbol (`vim.lsp.buf.rename`) |
| `<leader>e` | Toggle the neo-tree file explorer |
| `f` (all modes) | hop to any word on screen (overrides built-in find-char) |

### LSP navigation (Neovim native defaults)

Because servers are enabled through Neovim's native LSP, you also get the
built-in default keymaps when a server is attached (no extra config):

| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `grr` | References |
| `gri` | Go to implementation |
| `grt` | Go to type definition |
| `grn` | Rename symbol |
| `gra` | Code action |
| `gO` | Document symbols |
| `<C-s>` (insert) | Signature help |
| `[d` / `]d` | Previous / next diagnostic |

> Note: `<leader>gd`/`<leader>gr`/`<leader>rn` above are the LSP-aware versions
> bound by this config. The bare `gd` remains Neovim's built-in *go to local
> declaration* (works without LSP).

---

## Plugins

### neo-tree — file explorer

Sidebar file tree (replaces NERDTree / nvim-tree). Toggle it with `<leader>e`
(bound in `lua/keymaps.lua`) or a command:

| Command | Action |
|---------|--------|
| `:Neotree toggle` | Open / close the tree |
| `:Neotree reveal` | Open and reveal the current file |
| `:Neotree focus` | Jump into the tree window |

Inside the tree this config rebinds the keys to a **NERDTree-style** set (on top
of neo-tree's defaults):

| Key | Action |
|-----|--------|
| `o` | Open file / toggle folder |
| `t` | Open in a new tab |
| `i` / `s` | Open in horizontal / vertical split |
| `O` | Recursively open the node |
| `x` / `X` | Close parent node / close all nodes |
| `R` | Refresh |
| `I` | Toggle hidden files |
| `u` / `U` / `P` | Go up to the parent directory |
| `C` | Set the selected directory as root |
| `q` | Close the tree |
| `?` | Show all mappings |

neo-tree's default file operations still work too: `a` add, `d` delete, `r`
rename, `c`/`p` copy/paste. (Note `x` is remapped to close-node above, so use
neo-tree's menu for cut if you need it.)

### aerial — symbol outline

A code outline driven by LSP/treesitter (the modern replacement for tagbar — no
ctags needed). No custom keymap is bound:

| Command | Action |
|---------|--------|
| `:AerialToggle` | Open / close the outline window |
| `:AerialNavToggle` | Floating symbol navigator |

Inside the aerial window: `<CR>` jump to symbol, `p` preview/scroll to it,
`?` show mappings, `q` close.

### hop — fast on-screen jumps

EasyMotion-style motion: labels jump targets so you can leap anywhere visible.
This config binds `f` (all modes) to hop-to-word; you can also use the commands:

| Command | Action |
|---------|--------|
| `:HopWord` | Label every word and jump |
| `:HopChar1` | Jump to a typed character |
| `:HopLine` | Jump to a line |
| `:HopPattern` | Jump to a typed pattern |

> Tip: a common binding is `vim.keymap.set('', 'f', function() require('hop').hint_words() end, { remap = true })`.

### mason — language server installer

Installs and manages LSP servers. This config auto-installs **rust_analyzer**,
**lua_ls**, and **texlab**, then enables them through native LSP.

| Command | Action |
|---------|--------|
| `:Mason` | Open the installer UI |
| `:MasonInstall <pkg>` | Install a server/tool |
| `:MasonUpdate` | Update the registry |
| `:LspInfo` | Show servers attached to the buffer |

Inside the `:Mason` UI: `i` install, `u` update, `X` uninstall, `?` help.

### blink.cmp — completion

The completion engine. It pulls candidates from the LSP servers
(rust_analyzer + texlab), your luasnip snippets, the current buffer, and file
paths, and applies snippet capabilities to the servers automatically. See the
completion keymaps above.

### luasnip — snippets

The snippet engine behind blink's `snippets` source. Expand and jump through
placeholders with `<Tab>` / `<S-Tab>` (see the completion table).

> Note: luasnip ships **no** snippets by default — add your own, or install a
> collection such as `rafamadriz/friendly-snippets`.
