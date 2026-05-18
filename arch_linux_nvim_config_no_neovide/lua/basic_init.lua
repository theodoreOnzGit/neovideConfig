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
