-- lazy.nvim bootstrap + plugin declarations.
--
-- This file only DECLARES what to install. Configuration that needs real logic
-- (LSP + completion) lives in lua/lsp.lua; trivial setups stay inline here.

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

-- set <leader> BEFORE lazy loads so plugin mappings are correct
vim.g.mapleader = " "

local plugins = {
  -- file explorer (replaces NERDTree / nvim-tree)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
      "MunifTanjim/nui.nvim",
    },
    -- NERDTree-style in-tree keymaps (these override neo-tree's defaults)
    opts = {
      window = {
        mappings = {
          ["o"] = "open",         -- open file / toggle folder (NERDTree)
          ["t"] = "open_tabnew",  -- open in a new tab
          ["i"] = "open_split",   -- open in a horizontal split (NERDTree)
          ["s"] = "open_vsplit",  -- open in a vertical split (NERDTree)
          ["R"] = "refresh",      -- refresh the tree
        },
      },
      filesystem = {
        window = {
          mappings = {
            ["I"] = "toggle_hidden", -- toggle hidden files (NERDTree)
            ["P"] = "navigate_up",   -- go up to the parent directory
            ["C"] = "set_root",      -- make the selected directory the root
          },
        },
      },
    },
  },

  -- colorscheme. priority 1000 so it loads before other plugins; the config
  -- function applies it once the plugin is on the runtimepath.
  {
    "morhetz/gruvbox",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("gruvbox")
    end,
  },

  -- powerline-style statusline
  "vim-airline/vim-airline",
  "vim-airline/vim-airline-themes",

  -- symbol outline (modern tagbar replacement, no ctags). Uses its LSP backend.
  -- We intentionally do NOT depend on nvim-treesitter: on bleeding-edge Neovim
  -- (0.12) the archived `master` branch ships old parsers/queries that conflict
  -- with the core treesitter highlighter ("attempt to call method 'range'..."),
  -- while the `main` rewrite breaks telescope 0.1.x's `ft_to_lang`. Without it,
  -- aerial uses the LSP backend and telescope uses regex preview highlighting.
  {
    "stevearc/aerial.nvim",
    opts = {},
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- hop: easymotion-style jumps
  {
    "smoka7/hop.nvim",
    version = "*",
    opts = {},
  },

  -- git inside the editor. The author mainly uses lazygit now, but keeps
  -- fugitive around (handy as a cross-platform fallback, e.g. on Windows).
  "tpope/vim-fugitive",

  -- align text into columns by a delimiter (e.g. `ga=` to align on `=`)
  "junegunn/vim-easy-align",

  -- fuzzy finder (keymaps in lua/telescope_harpoon.lua)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- harpoon: quick file marks/jumps (v1 API; keymaps in lua/telescope_harpoon.lua)
  "ThePrimeagen/harpoon",

  -- snippet engine (LaTeX compiling is done externally via latexmk in a tmux
  -- pane, so no vimtex / in-editor compile is needed).
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp", -- optional: enables snippet transforms
  },

  -- LSP installer + native enabling (configured in lua/lsp.lua).
  -- NOTE: mason now lives under the `mason-org/*` org (was `williamboman/*`).
  "mason-org/mason.nvim",
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig", -- default server configs for vim.lsp
    },
  },

  -- completion engine (configured in lua/lsp.lua)
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = { "L3MON4D3/LuaSnip" },
  },

  -- Claude Code in the editor. `cond` makes the whole plugin a no-op when the
  -- `claude` CLI isn't on PATH, so Neovim never errors on machines without it
  -- (e.g. Windows). It also only loads when one of its commands is run.
  {
    "coder/claudecode.nvim",
    cond = function() return vim.fn.executable("claude") == 1 end,
    cmd = { "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeSend", "ClaudeCodeAdd" },
    opts = {
      terminal = { provider = "native" }, -- avoids extra UI deps like snacks.nvim
    },
  },
}

local opts = {
  -- colorscheme used while installing plugins
  install = { colorscheme = { "gruvbox" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
}

require("lazy").setup(plugins, opts)
