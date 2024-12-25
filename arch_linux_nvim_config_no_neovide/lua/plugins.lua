-- note: for lazy on Arch Linux, please install via AUR as well,
-- it's easier...
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {

    -- git gutter (may clash with ubuntu's existing git-gutter
	-- if on linux mint)
    -- use 'vim-scripts/vim-gitgutter'
    'preservim/nerdtree',
    'morhetz/gruvbox',
    'SirVer/ultisnips',
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	'neovim/nvim-lspconfig',
	'elementx54/moosefw_vim',
	'ranjithshegde/ccls.nvim',
	{'Myriad-Dreamin/tinymist'},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{                                      -- Optional
				'williamboman/mason.nvim',
				-- run = function()
				-- 	pcall(vim.cmd, 'MasonUpdate')
				-- end,
			},

			-- Autocompletion from snippets
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required

			-- buffer, path and commandline completion
			{'hrsh7th/cmp-buffer'},     -- Required
			{'hrsh7th/cmp-path'}, -- Required
			{'hrsh7th/cmp-cmdline'}, -- Required

		}
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"quangnguyen30192/cmp-nvim-ultisnips",
			config = function()
				-- optional call to setup (see customization section)
				require("cmp_nvim_ultisnips").setup{}
			end,
			-- If you want to enable filetype detection based on treesitter:
			-- requires = { "nvim-treesitter/nvim-treesitter" },
		}
	},

	-- telescope 
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.3',
		-- or                            , branch = '0.1.x',
		dependencies = { {'nvim-lua/plenary.nvim'} }
	},

	-- harpoon 
	'ThePrimeagen/harpoon',
	-- treesitter
	'nvim-treesitter/nvim-treesitter',

	
	-- airline 
	'vim-airline/vim-airline',
	'vim-airline/vim-airline-themes',

	-- tagbar
	'preservim/tagbar',

	-- fugitive 
	'tpope/vim-fugitive',

	-- vim latex
	'vim-latex/vim-latex',

	-- vim align (in the arch repos)
	'junegunn/vim-easy-align',

    -- ultisnips and snippets
	'honza/vim-snippets',

	-- hop nvim 
	{
		'smoka7/hop.nvim',
		version = '*',
		opts = {},
	}
}
local opts = {}


vim.g.mapleader = "\\" -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup(plugins, opts)

-- hop 
local hop = require('hop')
local directions = require('hop.hint').HintDirection

vim.keymap.set('','f', function()
	hop.hint_words({direction = directions.AFTERCURSOR})
end
, {remap=true})

-- ccls 
require("ccls").setup(config)
