-- Basic editor settings.

-- line numbers (absolute on the current line, relative on the others)
vim.opt.number = true
vim.opt.relativenumber = true

-- indentation: 4-space tabs, and don't soft-wrap long lines
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false

-- keep some context around the cursor when scrolling
vim.opt.scrolloff = 5

-- spell checking (British English). Custom words live in spell/en.utf-8.add
vim.opt.spell = true
vim.opt.spelllang = "en_gb"

-- visual guide at column 75 to hint at line length
vim.opt.colorcolumn = "75"

-- dark background; airline uses the matching dark theme (the gruvbox
-- colorscheme itself is applied in lua/plugins.lua once the plugin is loaded)
vim.opt.background = "dark"
vim.g.airline_theme = "dark"

-- classic syntax highlighting + filetype-based indentation
vim.cmd([[
syntax on
filetype plugin indent on
]])

-- force the `tex` filetype on .tex files so texlab attaches consistently
vim.cmd([[
autocmd BufNewFile,BufRead *.tex set filetype=tex
]])
