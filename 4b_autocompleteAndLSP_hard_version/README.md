# AutoComplete and LSP Hard version 


This is for times where 
I'm not really interested in quick out of the box
type solutions, but have more time to tinker...


One very popular autocomplete syntax checker type engine is ALE

https://www.youtube.com/watch?v=4FKPySR6HLk

https://github.com/dense-analysis/ale

These fall into the linter and fixer category. This is extremely powerful
but requires some kind of decent setup 
and tinkering to be useful. 

## Summary

We can split the lsp autocomplete and linting into:

1. LSP servers
2. LSP clients
3. Autocomplete
4. linting and fixing

vim-lsp takes info from lsp servers, eg flake8 and acts as
an lsp client. It can talk to the autocomplete via
async complete lsp plugins, and it also does linting or
error checks.

However, it CANNOT be a jack of all trades. We want a setup
where each plugin does the job it is best suited to.

1. ALE is better for linting. 
2. async complete is best for completions
3. vim-lsp is better for interaction with lsp server and
then talking to ALE and async complete

With this philosophy, we get the following init.vim:


## init.vim
Here is a basic setup for ALE:
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

    " LSP with ALE
    Plug 'dense-analysis/ale' 
    Plug 'rhysd/vim-lsp-ale' 


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

" ALE settings
" python and rust example
let g:ale_linters = {
\    'py' : ['vim-lsp'],
\    'rs' : ['vim-lsp']
\}
let g:airline#extensions#ale#enabled = 1

```
Install LSPs using (this is for vim-lsp-settings)

```vim
:LspInstallServer
```

Install Plugins using

```vim
:PlugInstall
```

### ALE Fixing

ALE also has this ability to auto-fix the formatting of your code

Here is an example you can add to your init.vim or .vimrc for rust

```vim
let g:ale_fixers = {
\    'rust' : ['rustfmt']
\}
```

After this, type the ALEFix command in vim to autoformat the code.
For rust, this is limited. This feature is more well developed
for python.


## other stuff..

If you want to paste in neovide or neovim:

When in command mode:
```
"+p
```















