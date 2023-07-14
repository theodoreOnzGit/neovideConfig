# Asthetics 
Here are things to make vim pleasing to the eyes

Just copy and paste the following:


## init.vim

```vim

" here are line number setups to help you move around using
" hjkl
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
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
call plug#end()

" Nerdtree settings; see hidden files with NerdTree
let NERDTreeShowHidden=1

"gruvbox colour theme

colorscheme gruvbox
set background=dark


" vim-airline themes
let g:airline_theme='dark'

```

Install Plugins using

```vim
:PlugInstall
```

If you want to paste in neovide or neovim:

When in command mode:
```
"+p
```

## colour columns 

While not technically a plugin, colour columns help you to make sure that 
a single line of code does not run too long.

```vim
" colour column 
set cc=75
```















