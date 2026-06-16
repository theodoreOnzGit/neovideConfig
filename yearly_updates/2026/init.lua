-- 2026 Neovim config (entry point)
--
-- This file only wires together the modules under lua/. Each concern lives in
-- its own file so it is easy to read and follow:
--   lua/settings.lua  -> basic editor settings (vim.opt)
--   lua/plugins.lua   -> lazy.nvim bootstrap + plugin declarations
--   lua/lsp.lua       -> language servers (mason) + completion (blink.cmp)

-- disable netrw at the very start (neo-tree handles file browsing)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable 24-bit colours in the terminal
vim.opt.termguicolors = true

-- basic editor settings
require("settings")

-- package manager + plugin declarations (also sets <leader> before lazy loads)
require("plugins")

-- language servers + completion
require("lsp")

-- fuzzy finder + harpoon keymaps
require("telescope_harpoon")

-- custom keymaps (LSP definition, neo-tree toggle, hop)
require("keymaps")
