Now, two of my favourite plugins whether or not you use lua are 
the fuzzy finder and the tagbar.

Fuzzy finder (fzf) written in Go allows you to find files quickly 
in your current directory. 

Tagbar allows you to navigate if your source file is very long. You 
are able to see a sidepane which helps you navigate between sections 
of code. Very sueful for LaTeX where there are long files.

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

    "git gutter and git integration
    Plug 'vim-scripts/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

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
	Plug 'rafamadriz/friendly-snippets'

	" vim latex

	Plug 'vim-latex/vim-latex'


    " LSP with ALE
    Plug 'dense-analysis/ale' 
    Plug 'rhysd/vim-lsp-ale' 

	" fzf
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }	

	" tagbar
    Plug 'preservim/tagbar'

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
noremap <C-Z> u

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

" colour column 
set cc=75

" spelling 
set spell
set spelllang=en_gb


```




## other stuff..

If you want to paste in neovide or neovim:

When in command mode:
```
"+p
```















