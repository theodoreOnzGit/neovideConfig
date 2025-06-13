-- disable netrw at start of init.lua 

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups 
vim.opt.termguicolors = true

-- package manager and plugins
require('plugins')
require('telescope_harpoon')

-- mason setup manager 
require("mason").setup()
require("mason-lspconfig").setup()

-- lsp
require('lsp')

-- hop 
require('hop_settings')


--basic settings, spellcheck and others
require('basic_init')

