-- note: for lazy on Arch Linux, please install via AUR as well,
-- it's easier...
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {

	-- git gutter (may clash with ubuntu's existing git-gutter
	-- if on linux mint)
	-- use 'vim-scripts/vim-gitgutter'
	'preservim/nerdtree',
	'morhetz/gruvbox',
	--'SirVer/ultisnips',
	'williamboman/mason.nvim',
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig", -- provides the defaults and configuration definitions
		},
		opts = {
			-- 1. Ensure texlab is automatically downloaded by Mason
			ensure_installed = { "texlab", "lua_ls" },

			-- 2. This hook handles the v0.12 native `vim.lsp.enable` automatically
			automatic_enable = true, 
		}
	},
	{
		"hrsh7th/nvim-cmp",
	},
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

	-- telescope 
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.3',
		-- or                            , branch = '0.1.x',
		dependencies = { {'nvim-lua/plenary.nvim'} }
	},

	-- harpoon 
	'ThePrimeagen/harpoon',


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
	-- tree, like NERDTree but another one in lua
	'nvim-tree/nvim-tree.lua',
	'nvim-tree/nvim-web-devicons',

	-- hop for neovim easymotions
	{
		'smoka7/hop.nvim',
		version = "*",
		opts = {},
	},
}
local opts = {}


vim.g.mapleader = "\\" -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup(plugins, opts)

