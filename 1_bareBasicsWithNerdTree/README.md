# Bare Basics with NerdTree

Here is an init.vim file with the bare minimum.

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

call plug#begin()
  Plug 'preservim/nerdtree'
call plug#end()

" Nerdtree settings; see hidden files with NerdTree
let NERDTreeShowHidden=1
```

Install Plugins using

```vim
:PlugInstall
```

## Quick fix for NERDTree menu issue (Oct 2022)

Now NerdTree had an annoying [bug](https://github.com/neovim/neovim/issues/20486) at one
point where the menu kept consuming space. 

In the latest vim and neovim patches, this was fixed. (as of Dec 2022)

One [workaround](https://github.com/preservim/nerdtree/issues/1321) 
then was to use the minimal menu in NERDTree.
I used to add this to my init.vim or .vimrc.

```vim
let g:NERDTreeMinimalMenu=1
```















