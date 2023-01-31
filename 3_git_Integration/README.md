# Git Integration

The most important git plugin for vim or neovim 
for me personally is:

vim-gitgutter:
https://github.com/airblade/vim-gitgutter

It helps you see git diffs within your vim setup:


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
    Plug 'vim-scripts/vim-gitgutter'
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
## Fugitive

Now, for people who get sick and tired of opening a new split window and shell 
to do git, I suggest you add fugitive. 

Using fugitive is like using git within your command line.
Instead of 

```zsh
git status
```

in terminal, you can type

```vim
:Git status
```
In the vim command line in command mode. Do this for the git add, git commit
and git push. It works with all those as well. 

```vim
:Git add .
```
```vim
:Git commit -m "my commit message"
```
```vim
:Git push
```

To install, you can refer to the following init.vim or .vimrc example:

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
    Plug 'vim-scripts/vim-gitgutter'
    " Here's where you add the fugitive plugin!
    Plug 'tpope/vim-fugitive'
call plug#end()

" Nerdtree settings; see hidden files with NerdTree
let NERDTreeShowHidden=1

"gruvbox colour theme

colorscheme gruvbox
set background=dark


" vim-airline themes
let g:airline_theme='dark'

```












