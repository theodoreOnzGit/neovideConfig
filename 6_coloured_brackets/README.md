# Coloured brackets

When I code using Rust,
I find a problem where there are so many nested brackets in my code
it becomes hard to keep track.

One useful plugin to help with this issue is vim-rainbow.

## init.vim
Here is a basic setup for vim-rainbow along with the previous plugins.
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

	" coloured curly brackets for easy working with nested
	" brackets
	Plug 'frazrepo/vim-rainbow'


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

" enable rainbow plugin
let g:rainbow_active = 1

```
Install LSPs using (this is for vim-lsp-settings)

```vim
:LspInstallServer
```

Install Plugins using

```vim
:PlugInstall
```

### Toggling the rainbow plugin

As shown in the [repo](https://github.com/frazrepo/vim-rainbow),
the two commands to toggle the rainbow effect are:

```vim
RainbowToggle
RainbowLoad
```




## other stuff..

If you want to paste in neovide or neovim:

When in command mode:
```
"+p
```















