-- for spelllcheck, and line numbers and some others
require('basic_settings.settings')


---- telescope and harpoon
--require('plugins.telescope_harpoon')


-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


-- lazy plugin manager
require('plugins')

-- telescope and harpoon settings 
require('telescope_harpoon')

-- Mason Lsp Setup manager (must load after lazy plugins start)
require("mason").setup()
require("mason-lspconfig").setup()

-- lsp settings 
require('lsp')
