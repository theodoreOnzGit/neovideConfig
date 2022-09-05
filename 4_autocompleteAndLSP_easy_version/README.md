# autocomplete and LSP easy version


## pre-requisites

For lsp, you will need:
1. cargo rust
https://doc.rust-lang.org/cargo/getting-started/installation.html
2. npm
https://nodejs.org/en/download/

## long preamble...

Now, we come to the part of autocompletion.

The most common autocompletion engines are COC and youcompleteme.

However, if you're looking for out of the box autocomplete and language
server protocol support, I recommend vim-lsp.

This will help to install language server protocols into your system, with
minimal effort to result ratio. (IMO anyway)

Here is the repo

https://github.com/prabirshrestha/vim-lsp

Unfortunately, vim-lsp is not exactly that compatible with youcomplete me
out of the box. And while youcompleteme has lsp support, you will have 
to spend a LOT of effort to get it configured for your language.

And for vim-lsp, the recommended completion engine is async completion.

To add in more functionality, I also use ultisnips which gives you lots
of options for inserting code snippets.

See here:

https://github.com/ycm-core/YouCompleteMe#lsp-configuration


Last but not least, syntax checking with synctastic.

https://github.com/vim-syntastic/syntastic

Now syntastic is being deprecated, and vim-ale is its
spiritual successor according to the author(s).

Here's the link to vim-ale:
https://github.com/dense-analysis/ale

It is very powerful but you need to learn a lot.

Here is a setup for all that without all the grind.

If you want to use my setup, 
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
"NerdTree
    Plug 'preservim/nerdtree'

    "asthetics
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'morhetz/gruvbox'

    "git gutter
    Plug 'vim-scripts/vim-gitgutter'

    "completion
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'

    "snippets
    Plug 'SirVer/ultisnips'

    " Language Server Protocol (LSP)
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'thomasfaingnaert/vim-lsp-snippets'
    Plug 'thomasfaingnaert/vim-lsp-ultisnips'


call plug#end()

" Nerdtree settings; see hidden files with NerdTree
let NERDTreeShowHidden=1

"gruvbox colour theme

colorscheme gruvbox
set background=dark


" vim-airline themes
let g:airline_theme='dark'

" ultisnips expand trigger [F4]
let g:UltiSnipsExpandTrigger="<F4>"



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


## Other Choices

Other honorable mentions i've seen:

### Easy Complete
https://github.com/jayli/vim-easycomplete













