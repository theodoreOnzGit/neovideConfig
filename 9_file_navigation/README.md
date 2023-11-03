Now, two of my favourite plugins whether or not you use lua are 
the fuzzy finder and the tagbar.

Fuzzy finder (fzf) written in Go allows you to find files quickly 
in your current directory. However, the telescope plugin takes it to 
a whole new level. 

Tagbar allows you to navigate if your source file is very long. You 
are able to see a sidepane which helps you navigate between sections 
of code. Very useful for LaTeX where there are long files.

The last one is harpoon, this serves as a good plugin to bookmark 
your files.

## init.vim for windows

Now, if you don't want to use packer or lazy nvim, and 
you are on windows with telescope and harpoon 
and want to just copy/paste everything in one file, 
here's your setup. Works great for windows because python 
is quite unreliable in windows.

```vim
set relativenumber
set number

" nowrap helps you see if you need to move to the next line
set nowrap

" basic syntax highlighting and auto-indenting
syntax on
filetype indent on
filetype plugin indent on
set tabstop=4
set shiftwidth=4

" makes scrolling easier
set scrolloff=5

"Plugins (only Nerdtree here)
" i use vim-plug here
"vim-airline for status bars at the bottom of your vim


call plug#begin()
"NerdTree
    Plug 'preservim/nerdtree'

    "asthetics
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'morhetz/gruvbox'

    "git gutter and git integration
    Plug 'vim-scripts/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    "completion
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'

    "snippets
    "Plug 'SirVer/ultisnips'

    " Language Server Protocol (LSP)
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'

    "snippet - LSP integration
    "Plug 'thomasfaingnaert/vim-lsp-snippets'
    "Plug 'thomasfaingnaert/vim-lsp-ultisnips'

    "python free LSP integration
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
	Plug 'rafamadriz/friendly-snippets'

	" vim latex

	Plug 'vim-latex/vim-latex'


    " LSP with ALE
    Plug 'dense-analysis/ale' 
    Plug 'rhysd/vim-lsp-ale' 

	" fzf
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }	
	Plug 'junegunn/fzf.vim'

	" tagbar
    Plug 'preservim/tagbar'

	" typst 
	Plug 'kaarmu/typst.vim'

	" telescope 
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.3' }

	" Harpoon 
	Plug 'ThePrimeagen/harpoon'

call plug#end()

" Nerdtree settings; see hidden files with NerdTree
let NERDTreeShowHidden=1

"gruvbox colour theme

colorscheme gruvbox
set background=dark


" vim-airline themes
let g:airline_theme='dark'

" ultisnips expand trigger [F4]
"let g:UltiSnipsExpandTrigger="<F4>"

" ALE settings
" python and rust example
let g:ale_linters = {
\    'py' : ['vim-lsp'],
\    'rs' : ['vim-lsp']
\}
let g:airline#extensions#ale#enabled = 1
noremap <C-Z> u

" Lsp code actions and whatnot 

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
	nnoremap <buffer> gD <plug>(lsp-declaration)
	nnoremap <buffer> <C-k> <plug>(lsp-signature-help)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    "nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <space>rn <plug>(lsp-rename)
    nmap <buffer> [d <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]d <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)

	nnoremap <buffer> <space>ca <plug>(lsp-code-action)
	vnoremap <buffer> <space>ca <plug>(lsp-code-action)

    " refer to doc to add more commands
    let g:lsp_format_sync_timeout = 1000
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" colour column 
set cc=75

" spelling 
set spell
set spelllang=en_gb

" fzf preview
let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['right,50%', 'ctrl-/']

" telescope keybindings 
" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


" Harpoon quick setup 

nnoremap <leader>b <cmd>lua require("harpoon.mark").add_file()<cr>
nnoremap <leader><Esc> <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>
nnoremap <leader>q <cmd>Telescope harpoon marks<cr>
lua require("telescope").load_extension('harpoon')
```

## init.lua for windows python free

Now, if you really want to use the full power of a lua setup 
on windows and want to avoid python, I'll also provide a setup 
for lazy nvim that's as far as possible, python free 
(no ultisnips but rather vsnips).

I'll make it easy so u just copy and paste everything in one 
go. Here's your init.lua:


```lua 
-- basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false

-- makes scrolling easier
vim.opt.scrolloff = 5

-- for spelling
vim.opt.spell = true
vim.cmd("set spelllang=en_gb")


-- syntax
vim.cmd([[
syntax on
filetype indent on
filetype plugin indent on
]])

-- enables vim-latex on all .tex files
vim.cmd([[
autocmd BufNewFile,BufRead *.tex set filetype=tex
"autocmd BufNewFile,BufRead *.typ set filetype=typst
]])

-- color column
vim.cmd("set cc=75")

-- for NERDTree specifically
vim.cmd([[
let NERDTreeShowHidden=1
]])


-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


-- lazy plugin manager
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
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	'neovim/nvim-lspconfig',
	{'kaarmu/typst.vim', ft = {'typst'}},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{                                      -- Optional
				'williamboman/mason.nvim',
				run = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
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
    'hrsh7th/vim-vsnip',
    'hrsh7th/vim-vsnip-integ',
	'rafamadriz/friendly-snippets',
}
local opts = {}


vim.g.mapleader = "\\" -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup(plugins, opts)

-- telescope settings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- harpoon settings
require("telescope").load_extension('harpoon')
vim.cmd([[
nnoremap <leader>b <cmd>lua require("harpoon.mark").add_file()<cr>
nnoremap <leader><Esc> <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>
nnoremap <leader>q <cmd>Telescope harpoon marks<cr>
]])

-- Mason Lsp Setup manager (must load after lazy plugins start)
require("mason").setup()
require("mason-lspconfig").setup()

-- lsp settings 
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

-- for typst
require 'lspconfig'.typst_lsp.setup {}

-- for completion

local cmp = require 'cmp'

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			 vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			--vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' }, -- For vsnip users.
		--{ name = 'luasnip' }, -- For luasnip users.
		--{ name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
		{ name = 'buffer' , option = {
			get_bufnrs = function()
				return vim.api.nvim_list_bufs()
			end
		}
	},
	{ name = 'path' },
})
})

-- keybindings



-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})

-- colorscheme
vim.cmd([[
colorscheme gruvbox
set background=dark
let g:airline_theme='dark'
]])
```

## other stuff..

If you want to paste in neovide or neovim:

When in command mode:
```
"+p
```















