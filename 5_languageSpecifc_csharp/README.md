# OmniSharp vim



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

However, vim-lsp-settings doesn't natively support 
dotnet core version of C#, only mono.

For that, we use omnisharp.
http://www.omnisharp.net/

Remember, we want to use each program for what it is best
suited for.

1. ALE is better for linting. 
2. async complete is best for completions
3. omnisharp is best for lsp server interaction for C#
4. vim-lsp works okay as a lsp client for other languages

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

    " Csharp C# support
    Plug 'OmniSharp/omnisharp-vim'
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
\    'rs' : ['vim-lsp'],
\    'cs' : ['OmniSharp']
\}
let g:airline#extensions#ale#enabled = 1


" omnisharp C# settings
let g:OmniSharp_server_use_net6 = 1



```
Install OmniSharp using:

```vim
:OmniSharpInstall
```
Install Plugins using

```vim
:PlugInstall
```
## Prerequisites
for this, you should have dotnet core installed (obviously):
```powershell
winget install Microsoft.DotNet.SDK.6
```

This is in addition to the other pre-requisties you have on
on the main README.md page.

## other stuff..

If you want to paste in neovide or neovim:

When in command mode:
```
"+p
```















