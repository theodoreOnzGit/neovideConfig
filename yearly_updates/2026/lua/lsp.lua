-- Language servers + completion.
--
-- The plugins themselves are declared in lua/plugins.lua; this file holds the
-- actual configuration so the LSP logic is easy to find and read.

-- install + manage language servers
require("mason").setup()

-- ensure the servers we want are installed, then enable them through Neovim's
-- native LSP. `automatic_enable` calls vim.lsp.enable() for installed servers,
-- so we no longer need lsp-zero.
require("mason-lspconfig").setup({
  -- rust_analyzer is crucial for this config.
  -- NOTE: mason installs the rust-analyzer binary, but it analyses against your
  -- installed Rust toolchain, so you still need rustup/cargo on the system
  -- (e.g. Arch: sudo pacman -S rustup && rustup default stable).
  ensure_installed = { "rust_analyzer", "lua_ls", "texlab" },
  automatic_enable = true,
})

-- completion engine: blink.cmp.
-- Pulls items from the LSP source (rust_analyzer + texlab) and the luasnip
-- snippets source, and applies snippet capabilities to the servers
-- automatically. luasnip is the snippet engine.
require("blink.cmp").setup({
  snippets = { preset = "luasnip" },
  sources = { default = { "lsp", "snippets", "buffer", "path" } },

  -- keymaps mirror the previous nvim-cmp bindings so existing muscle memory is
  -- preserved (these apply only inside the completion popup).
  keymap = {
    preset = "enter",                                                      -- <CR> confirms selection
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" }, -- trigger completion
    ["<C-e>"] = { "hide", "fallback" },                                    -- abort/close
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },                 -- scroll docs up
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },               -- scroll docs down
    -- <Tab>/<S-Tab> (from the enter preset) jump between snippet placeholders
  },
})
