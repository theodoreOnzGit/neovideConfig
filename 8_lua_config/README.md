# Why Lua?

For neovim in general, you don't really unlock its full potential
until you use lua. I had quite a good time using the vim-lsp setup
previously and was lazy to learn lua, yet another coding language,
but there was a new filetype called typ for typst.

For the uninitiated, typst is a potential replacement for LaTeX. It
compiles much faster, is written in Rust, and its syntax is much
easier to use.

[Here's the link to typst](https://github.com/typst/typst).

Now neovim has native LSP baked into its code unlike vim. And neovim's
lsp configuration had typst integrated extremely quickly as a filetype.
This was very impressive to me.
Couple that to the fact that lua is considered to be a
[faster](https://sr.ht/~henriquehbr/lua-vs-vimscript/) code
than vimscript, and you have a strong case to want to move to lua.

And hence I wanted to give neovim with lua config a shot. And of course
as I watched the [Primeagen's](https://github.com/ThePrimeagen)
zero to LSP videos and
the [Kickstarter](https://github.com/nvim-lua/kickstart.nvim) neovim
project, I wanted more and more to give lua in neovim a shot.

## Intro to vimscript vs lua Config Files

### init.vim vs init.lua

Now, I'm assuming most who are reading already have familiarity
programming a .vimrc or init.vim file. For lua files, we make
a lua file in our config directory. Here's where you should make it:

```bash
~/.config/nvim/init.lua
```

Now if you happen to have init.vim in the same directory, neovim
will ONLY read the init.lua file. Furthermore, it will complain about
having conflicting configuration files there. So what we can do is
rename our init.vim as another file so that we can start "clean".
I say "clean" because
we will still have plugins installed from our previous package
manager, which we may want to clean manually.

Now if you ever panic and want to use vimscript, there is one
command which can allow you to use vimscript within a lua file.
So within your init.lua, you can use:

```lua
vim.cmd([[
        syntax on
        filetype indent on
        filetype plugin indent on
        set number 
        set relativenumber
        set tabstop=4
        set shiftwidth=4
        set nowrap
]])
```

This will allow you to use your vim configurations within lua.

### lua syntax and comments

If you really want to switch to lua, you'll probably want to use a more
"lua like" syntax. To do so, we need to understand some basic syntax.
Double dashed lines are for comments in lua, and we can treat the syntax
quite similarly to python in that there are no semicolons, and we treat
it very much like an object oriented language.

Here is an example of some other syntax we can use in lua.

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
```

For lua, we also can source files rather painlessly using the
require command. This is fairly common practice in programming
as well where we want to split one big source file into multiple
files and folders if it gets too big.
For the config folder, all the lua files are
automatically read from the lua folder.

The lua folder's path is:

```bash
~/.config/nvim/lua/
```

Let's say we have a file structure like so, and we want to
include the following lua files:

```bash
~/.config/nvim/lua/basic_settings/settings.lua
~/.config/nvim/lua/plugins/plugins.lua
~/.config/nvim/lua/plugins/lsp.lua
```

We would just use the require command:

```lua
-- for spelllcheck, and line numbers and some others
require('basic_settings.settings')

-- package manager
require('plugins.plugins')

-- treesitter
require('plugins.lsp')
```

Notice that folders are separated by periods "." . The second thing
to note is that the lua folder does not need to be included there.
This is because neovim will automatically search the lua folder within
the config folder for any lua source files. It is on its "PATH" variable
so to speak.

## My Personal Ingredients for a Productive Vim/Neovim experience

For vim or neovim, I would consider that a productive
coding experience has four to five ingredients:

- Language Server Protocol (LSP), including autocomplete and snippets
- Syntax Highlighting
- Navigation via File Explorer, Fuzzy File Finder or Tagbar
- Git integration

In my previous config, i had some of the plugins written in vimscript
cover these functions.

1. LSP, autocomplete and snippets were done using ALE, vim-lsp and
ultisnips
2. Syntax Highlighting via language specific plugins such as vim-latex
and vim's regular regex (regular expression) syntax highlighting.
3. Navigation via [NERDTree](https://github.com/preservim/nerdtree).
Navigation in Arch Linux via Fuzzy File Finder (fzf) was made
exceptionally easy since installing fzf from pacman also includes
installing the vimscript [plugin](https://github.com/junegunn/fzf)
by default. The [vim tagbar](https://github.com/preservim/tagbar)
was also easily installed via the package manager and could be used
without any further configuration.
4. Git integration via
[gitgutter](https://github.com/airblade/vim-gitgutter) and
[fugitive](https://github.com/tpope/vim-fugitive) was also made easy
via the package manager, which allowed for these things to be installed
without further configuration.

Sticking to vimscript had the advantage of the config file being usable
in vim and neovim. So there is compatibility. However, if you want to
try and do neovim the lua way, you'll need to use some lua plugins. Of
course, it is entirely possible to have some plugins in vimscript and
some in lua, and you'll likely have this mix of plugins in neovim anyhow
because some plugins in vimscript such as fugitive are just more mature
than their lua counterparts. But the LSP server and clients in lua is
really that much easier to use.

Thanks to the Primeagen's videos, I've seen a few major changes that have
somewhat improved my neovim experience.

1. LSP via [lsp-zero](https://github.com/VonHeikemen/lsp-zero.nvim). This
already includes many other snippet, LSP and other such plugins. It uses
luasnip and [vim-cmp](https://github.com/hrsh7th/nvim-cmp) by default. But
you can make changes so that we use ultisnips if we want.
2. Syntax highlighting via
[TreeSitter](https://github.com/nvim-treesitter/nvim-treesitter). Now
Treesitter provides MUCH better syntax highlighting than the normal vim
syntax highlighting. And it can do so much more. However, for now I just
use it for syntax highlighting.
3. [Telescope](https://github.com/nvim-telescope/telescope.nvim) and
[harpoon](https://github.com/ThePrimeagen/harpoon) for file navigation.

Now, I'm more used to FZF for file navigation, and frankly harpoon
seemed to be too little bang for too much buck for my use cases. It would
be interesting to explore though. Fugitive is also used, but it was
already in the vimscript version of the config file. I would lump
these all under the category of fuzzy file finding navigation, so if
you don't have a prior fuzzy file finder, do give these a shot.

Moreover, I found that NERDTree had lua alternatives such as
[nvim-tree](https://github.com/nvim-tree/nvim-tree.lua). To be honest,
I was already satisfied with NERDTree. And I have installed both on the
same machine and could use either. Muscle memory would already have me
use NERDTree. So I don't really fancy changes now.

## Package Managers

The Primeagen recommended
[Packer](https://github.com/wbthomason/packer.nvim) as opposed to
vim-plug. From what I've read online, the degree of customisation
available via packer can exceed that of vim-plug since one can define
dependencies and such. Another popular package manager is
[Lazy](https://github.com/folke/lazy.nvim). Both are good, but for
my personal use case, vim plug seems sufficient. However, I tried
migrating to packer just to try out the experience. It doesn't seem too
bad.

The most important game changer is, in my opinion, mason.
[Mason](https://github.com/williamboman/mason.nvim) is not
a plugin package manager, but rather a LSP package manager. It pretty
much like vim-lsp-settings for the native neovim LSP client. It provides
easier installs for various LSPs for neovim. Highly highly recommend it.

## A Basic Lua and Vimscript setup

In this folder, I have a basic lua and vimscript setup. My init.lua is
as follows:

```lua
-- for spelllcheck, and line numbers and some others
require('basic_settings.settings')

-- package manager
require('plugins.plugins')

-- treesitter and lsp
require('plugins.lsp')
require('plugins.treesitter')



-- for nvim-tree, not really that critical
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
```

Here, I'm importing some other lua files in a basic_settings and plugins
folder. Both of these are housed under a lua folder.

My settings file includes some basic settings for line numbering and
so forth

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

-- colorscheme
vim.cmd([[
colorscheme gruvbox
set background=dark
let g:airline_theme='dark'
]])

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
```

Now for package management, this is a packer config:

```lua
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- tree, like NERDTree but another one in lua
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'

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
end)

```

Note that fugitive, fzf, git gutter and tagbar are not included here because
they are installed with Arch Linux's package manager. You'll have to
install the plugins yourself. I also tried NvimTree for fun.

Now for lsp setup, you don't really have to enforce these defaults if
you have lsp zero but they are just my preference:

```lua
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
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
		{ name = 'luasnip' }, -- For luasnip users.
		{ name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = 'buffer' },
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
```

I wanted to configure [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) a
little more because many useful LaTeX snippets already existed within
ultisnips. Hence I used ultisnips rather than luasnips. The speed
difference didn't affect me much. Also, I copied and pasted some of
the lsp configs from
[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) so that
I could really make use of the full power of neovim's lsp. When keymaps
are explicitly set, it is easier for me to remember how to use them.
With vim-lsp in vimscript
you can also do the same things, but a copy and paste config was
harder to find.

The last one is really important, treesitter. You HAVE to manually
activate it in order to see its effects.

```lua
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query",
  "rust", "python", "foam"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    --     local max_filesize = 100 * 1024 -- 100 KB
    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --     if ok and stats and stats.size > max_filesize then
    --         return true
    --     end
    -- end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true
	}
}
```

And there you go...

I've provided some of these lua files which include the plugins I described
here plus some other plugins in this folder. Should be convenient to get
neovim setup.
