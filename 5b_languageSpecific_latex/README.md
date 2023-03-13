# Vim Latex

I haven't used many plugins with vim latex before,

However, one I've found useful and am quite happy with
is vim-latex. This helps to provide several snippets and
tools for writing sections, and typeset math very
quickly.

One issue though I've encountered is dealing with folders that
have several source files. This means when I split my latex
document into several tex documents, the vim-latex doesn't
activate when trying to enter those smaller source documents.

## Force Vim Latex to Recognise TeX files

To sort this issue,

https://tex.stackexchange.com/questions/543915/how-do-i-deal-with-projects-with-multiple-files-sing-vim-latex

in Command mode
```vim
:set filetype=tex
```

According to the stackexchange also, you can put this at the top of your latex file:
```tex
% vim: set filetype=tex :
```

Or add this to init.vim or .vimrc
```vim
autocmd BufNewFile,BufRead *.tex set filetype=tex
```