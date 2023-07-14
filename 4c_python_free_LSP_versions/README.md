# AutoComplete, LSP and ALE Python Free version

Sometimes python is superbly annoying to use on windows due to 
pathing issues with neovim.

Thus, you can also opt to use plugins without python.

Mainly we just need to find a replacement for ultisnips

We are mainly taking out ultisnips and other python dependent plugins.

The snippet engine i go with is vim-vsnip. This is recommended on
the async complete plugin page. 

However, the snippet engine is not as out of the box user friendly
as ultisnips.

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
Here is a basic setup for python free LSP and ALE:
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
    "Plug 'SirVer/ultisnips'

    " Language Server Protocol (LSP)
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'

    "snippet - LSP integration
    "Plug 'thomasfaingnaert/vim-lsp-snippets'
    "Plug 'thomasfaingnaert/vim-lsp-ultisnips'

    "python free LSP integration
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'


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
"let g:UltiSnipsExpandTrigger="<F4>"

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

## LspHover and Code Actions 

Based on the recommendations by the author of vim lsp, here are 
some of the functions we can use to fully utilise our lsp 
capability. For example, LspHover allows you to read descriptions 
of things you just typed in. I used K for LspHover. 

This is somewhat intuitive because k scrolls vim upwards. A capital 
K brings up the description, as if you're bringing UP a popup. So the 
idea of "up" sticks with k.

The second one which is quite good is code actions. Code actions allow 
you to do several quick fixed depending on the Lsp Server. For Rust, you 
are allowed to remove and add imports for example.

```vim

" Lsp code actions and whatnot 

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
	nnoremap <buffer> gD <plug>(lsp-declaration)
	nnoremap <buffer> <C-k> <plug>(lsp-signature-help)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    "nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <space>rn <plug>(lsp-rename)
    nmap <buffer> [d <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]d <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)

	nnoremap <buffer> <space>ca <plug>(lsp-code-action)
	vnoremap <buffer> <space>ca <plug>(lsp-code-action)

    " refer to doc to add more commands
    let g:lsp_format_sync_timeout = 1000
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
```

I sometimes follow the convention used by nvim-lspconfig so that it 
is easier to switch around

## other stuff..

If you want to paste in neovide or neovim:

When in command mode:
```
"+p
```

















