# 2026 Neovim config update — context

This folder is the **2026 edition** of the step-by-step Neovim config in this repo.
The repo originally targeted Neovide, but the author no longer uses Neovide — these
configs are plain Neovim.

## Background

- The repo teaches a user, step by step, how to build up a Neovim config
  (folders `1_*` through `9_*`, each with its own README).
- The author's real/working config lives in `arch_linux_nvim_config_no_neovide/`
  and is kept in sync with `~/.config/nvim` (they were byte-identical as of this
  session, except the repo also carries a `spell/` folder).
- `yearly_updates/2026/init.lua` started as a bare lazy.nvim + NERDTree starter
  and is being modernized toward the author's preferred 2026 stack.

## Decisions made this session (2026-06-16)

1. **Drop `lsp-zero`.** In the old Arch config, `lsp-zero v2.x` was listed in
   `plugins.lua` but never actually used by `lsp.lua` (dead weight). The 2026
   edition should not include it.
2. **Use native `vim.lsp.enable`** for enabling language servers (Neovim 0.11+
   native LSP), rather than relying on lsp-zero. `mason-lspconfig` with
   `automatic_enable = true` already calls `vim.lsp.enable` under the hood; the
   open sub-decision is whether to keep mason-lspconfig for auto-enable or go
   fully manual with `vim.lsp.config(...)` + `vim.lsp.enable(...)`.
   **(Not yet implemented in the 2026 init.lua.)**
3. **File explorer: neo-tree replaces NERDTree and nvim-tree.** The old Arch
   config ran both NERDTree and nvim-tree side by side. The 2026 edition uses
   only `nvim-neo-tree/neo-tree.nvim` (branch `v3.x`).
   - Deps: `plenary.nvim` (already pulled by telescope), `nvim-web-devicons`
     (already present), and the one genuinely new dep `MunifTanjim/nui.nvim`.
   - The author declined a default toggle keymap here — keymaps are personal
     preference and live elsewhere.
4. **Keep the classics the author finds useful:** `vim-airline` (+ themes)
   powerline statusline and `smoka7/hop.nvim` (easymotion jumps). Modern
   equivalents offered but declined for now: airline → lualine.nvim,
   hop → flash.nvim.
5. **Symbol outline: aerial.nvim replaces tagbar.** The author initially wanted
   tagbar but on second thought chose `stevearc/aerial.nvim` instead — it uses
   LSP/treesitter as its backend (no ctags needed). Deps: nvim-treesitter and
   nvim-web-devicons (both optional; devicons already present).

## External (non-plugin) dependencies

- (none currently — aerial replaced tagbar, so ctags is no longer required.)

6. **mason LSP suite ported (lsp-zero-free).** Added `mason-org/mason.nvim` +
   `mason-org/mason-lspconfig.nvim` (dep: `neovim/nvim-lspconfig`) with
   `automatic_enable = true`, which is what calls native `vim.lsp.enable()` for
   installed servers — this implements decisions 1 & 2. `ensure_installed`
   includes **`rust_analyzer` (crucial for this config)**, plus `lua_ls` and
   `texlab`. Note: mason packages now live under the `mason-org/*` GitHub org
   (formerly `williamboman/*`).

7. **LaTeX: drop vim-latex; texlab + luasnip only.** The old Arch config used
   `vim-latex/vim-latex`, but it is outdated and largely redundant. texlab (LSP)
   covers completion/diagnostics/navigation. The author only wants **snippets**
   from the old LaTeX setup, so `L3MON4D3/LuaSnip` was added and vim-latex is NOT
   ported. No vimtex / in-editor compile needed: the author **compiles
   externally** in a tmux pane with `latexmk -pvc -pdf --interaction=nonstopmode
   filename.tex`.

8. **Completion engine: blink.cmp (chosen over nvim-cmp).** `saghen/blink.cmp`
   added as the single completion plugin (dep: luasnip). Sources: `lsp`
   (rust_analyzer + texlab), `snippets` (luasnip), `buffer`, `path`. blink
   applies snippet capabilities to the servers automatically (the easy thing to
   get wrong with nvim-cmp). luasnip is the snippet engine via
   `snippets = { preset = "luasnip" }`.
   - **Keymaps: the author wanted to KEEP the existing nvim-cmp bindings.**
     blink's default preset uses `<C-y>` to accept, so we used `preset = "enter"`
     (so `<CR>` confirms) plus overrides for `<C-space>` (show), `<C-e>` (hide),
     `<C-b>`/`<C-f>` (scroll docs) — mirroring the old `lsp.lua` cmp mappings.
     `<Tab>`/`<S-Tab>` jump snippet placeholders (was unused before, so additive).
     These keymaps live in `opts.keymap` and only apply in the completion popup.

9. **Modular file structure (mirrors the old Arch layout).** Per the author's
   preference, the single `init.lua` was split into a thin entry point that
   `require`s modules, with content under `lua/` — easier for the end user to
   read and follow:
   ```
   2026/
   ├── init.lua          # thin: disables netrw, termguicolors, requires modules
   └── lua/
       ├── settings.lua  # basic vim.opt editor settings
       ├── plugins.lua   # lazy bootstrap + plugin DECLARATIONS + mapleader
       └── lsp.lua       # mason servers + blink.cmp config (explicit .setup())
   ```
   Convention: `plugins.lua` only *declares* plugins; real config logic (LSP +
   completion) lives in `lsp.lua` via explicit `require(...).setup()` calls,
   matching how the old Arch `lsp.lua` held the cmp config. Trivial plugin opts
   (hop, aerial, neo-tree deps) stay inline in `plugins.lua`. `<leader>` is set
   to Space in `plugins.lua` before `lazy.setup`.

10. **Ported remaining settings from the Arch config.**
    - **gruvbox** colorscheme added in `plugins.lua` (priority 1000 + a `config`
      function calling `vim.cmd.colorscheme("gruvbox")`); `background=dark` and
      `g:airline_theme="dark"` set in `settings.lua`; lazy `install.colorscheme`
      switched habamax → gruvbox.
    - **fugitive** kept (`tpope/vim-fugitive`). The author mainly uses **lazygit**
      now, but keeps fugitive as a cross-platform fallback (lazygit is awkward on
      Windows).
    - **vim-easy-align** (`junegunn/vim-easy-align`) kept — aligns text into
      columns by a delimiter (e.g. `ga=`).
    - **Spellcheck kept**: `spell=true`, `spelllang=en_gb` in `settings.lua`, and
      the `spell/` folder (custom dictionary `en.utf-8.add` + `.spl`) copied in.
    - Also ported basic settings: tabstop/shiftwidth=4, nowrap, `syntax on`,
      `filetype plugin indent on`, and the `*.tex` → `tex` filetype autocmd.
    - **NOT ported (intentional):** the NERDTree-only `NERDTreeShowHidden` line
      (neo-tree replaced it), and the keymap files `telescope_harpoon.lua` /
      `hop_settings.lua` (the author manages their own keymaps).

11. **telescope + harpoon ported (with keymaps).** Declared
    `nvim-telescope/telescope.nvim` (branch `0.1.x`, dep plenary) and
    `ThePrimeagen/harpoon` in `plugins.lua`. Keymaps imported verbatim from the
    old Arch `telescope_harpoon.lua` into `lua/telescope_harpoon.lua` and wired
    via `require("telescope_harpoon")` in `init.lua`. **harpoon stays on the v1
    API** (`harpoon.mark`, `harpoon.ui`, telescope `harpoon` extension) to match
    the imported keymaps — do NOT bump to harpoon2 without rewriting them.
    Keymaps: `<leader>ff/fb/fh` (find_files/buffers/help_tags), `<leader>b` (mark
    file), `<leader><Esc>` (toggle quick menu), `<leader>q` (Telescope harpoon
    marks). `<leader>` = Space.

12. **README.md added** for the 2026 edition: requirements, file layout, a
    keymap quick-reference (telescope/harpoon/blink bindings + Neovim native
    default LSP keymaps), and per-plugin usage for neo-tree, aerial, hop, mason,
    blink, luasnip. Note: `gd` is documented as Neovim's built-in *go to local
    declaration* (the author confirmed they rely on it); LSP cross-file
    definition would need an explicit map. Snippet *content* (friendly-snippets
    etc.) intentionally deferred — luasnip ships none by default.
13. **Deployed to `~/.config/nvim`.** The 2026 edition was copied into the live
    Arch config. The previous live config (which matched
    `arch_linux_nvim_config_no_neovide/`) was backed up to a timestamped
    `~/.config/nvim.bak-<timestamp>` folder before overwriting. The old config
    also still lives in the repo at `arch_linux_nvim_config_no_neovide/` as
    reference. Validated with a headless `Lazy! sync` + clean load.

14. **Claude Code integration (`coder/claudecode.nvim`).** Added to
    `plugins.lua`. Key requirement: it must NOT error/crash Neovim when the
    `claude` CLI is unavailable (e.g. Windows). Achieved with
    `cond = function() return vim.fn.executable("claude") == 1 end` — when the
    CLI is absent, lazy treats the plugin as a no-op (installed but not loaded/
    configured, no commands). Also lazy-loaded via `cmd = { ClaudeCode, ... }`
    and `terminal = { provider = "native" }` to avoid a snacks.nvim dependency.
    Keymaps left to the author (point them at `:ClaudeCode` etc.; optionally
    guard them with the same `executable("claude")` check).

15. **Custom keymaps added (`lua/keymaps.lua`, required from `init.lua`).** During
    testing the author asked for three bindings (leader = Space):
    - `<leader>gd` → `vim.lsp.buf.definition` (LSP go-to-definition, so it jumps
      to the real function — NOT the built-in local-declaration `gd`).
    - `<leader>e` → `:Neotree toggle`.
    - `f` (all modes) → `require("hop").hint_words({ current_line_only = false })`
      so `f` starts hopping. This overrides the built-in `f` (find-char), matching
      the old config. (hop "wasn't working" before only because no keymap was
      bound — the hop_settings.lua keymap file was intentionally not ported.)

16. **neo-tree given NERDTree-style in-tree keymaps.** Added `opts.window.mappings`
    (and `opts.filesystem.window.mappings`) to the neo-tree spec in `plugins.lua`,
    overriding neo-tree's defaults: `o` open file/toggle folder, `t` open in tab,
    `i` horizontal split, `s` vertical split, `R` refresh, `I` toggle hidden,
    `P` navigate up, `C` set root. The headline request was `o` = open. Verified
    by opening the neo-tree buffer headless and reading its keymaps.

17. **`\ff` finder prefix + harpoon/treesitter error fix.**
    - Telescope finders rebound from `<leader>f*` to a literal `\` prefix per the
      author: `\ff` (find_files), `\fb` (buffers), `\fh` (help_tags) in
      `telescope_harpoon.lua`. Harpoon keymaps stay on `<leader>` (Space).
    - **Bug fixed:** opening harpoon's telescope picker threw an `ft_to_lang`
      error. Root cause: `nvim-treesitter` installed on its new default `main`
      branch (a rewrite that removed `ft_to_lang`), while telescope 0.1.x calls
      `require("nvim-treesitter.parsers").ft_to_lang` for previews. Fix: pinned
      the aerial dependency to `{ "nvim-treesitter/nvim-treesitter", branch =
      "master", build = ":TSUpdate" }`. **Do NOT let treesitter drift back to
      `main`** while telescope is on 0.1.x. (The harpoon "Couldn't find a valid
      file name to mark" seen in headless was just an empty buffer, not a bug.)

## TODO / not yet done
- vim-latex intentionally dropped (see decision 7); LaTeX = texlab + luasnip.
- If custom rust-analyzer settings are ever needed, add a
  `vim.lsp.config('rust_analyzer', { settings = { ... } })` block (native API).
