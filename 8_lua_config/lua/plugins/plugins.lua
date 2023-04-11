vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- tree, like NERDTree but another one in lua
	use 'nvim-tree/nvim-tree.lua'
	use 'nvim-tree/nvim-web-devicons'

	-- NERDTree
    use 'preservim/nerdtree'

	-- gruvbox theme
    use 'morhetz/gruvbox'

    -- git gutter
    use 'vim-scripts/vim-gitgutter'

    -- ultisnips
    use 'SirVer/ultisnips'

	-- typst
	use {'kaarmu/typst.vim', ft = {'typst'}}

	-- treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}


	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{                                      -- Optional
				'williamboman/mason.nvim',
				run = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
		}
	}
	-- your ultisnips should also be integrated into the completion
	-- engine not just through the use of sources.
	-- but a third party plugin also...
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"quangnguyen30192/cmp-nvim-ultisnips",
			config = function()
				-- optional call to setup (see customization section)
				require("cmp_nvim_ultisnips").setup{}
			end,
			-- If you want to enable filetype detection based on treesitter:
			-- requires = { "nvim-treesitter/nvim-treesitter" },
		}
	})
end)

