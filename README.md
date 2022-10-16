# neovideConfig
Configuration for Neovide on windows (and maybe other systems)

# windows-10 install:

I made this because i love my archlinux vim setup, but am sometimes forced
to work on windows. 

Neovide seemed to be a decent vim or neovim GUI which is able to 
offer 

1. me out of the box nerdfonts and other symbols, 
2. hardware accelerated (OpenGL) performance 
3. asthetics

My emphasis for the setup is:

1. ease of setup; minimal scripting
2. asthetics
3. IDE like functionality with autocomplete, snippets and language server 
protocol (LSP)

## 1. Instaling Nvim

```powershell
winget install Neovim.Neovim
```

## 2. Instaling git

```powershell
winget install -e --id Git.Git
```


## 3. Installing neovide (or windows terminal)

Go here:
https://github.com/neovide/neovide/releases/tag/0.10.1

Now, neovide requires OpenGL, and the main reason i use
it is because it is preconfigured with fonts.

If on a virtual machine, windows terminal does
pretty much the same thing

https://docs.microsoft.com/en-us/windows/terminal/install

The only thing is that Ctrl+Shift+n will make a new terminal
window.

However, neovim sometimes uses that same key binding. So
delete the binding in windows terminal or remap neovim.

(I prefer deleting the windows terminal binding).

### 3b. In case you are using Powershell and not Neovide

In powershell when using windows terminal, if you happen
to use windows terminal, Ctrl-Z happens to freeze neovim. 

The muscle reflex on windows unfortunately is that Ctrl-Z
will undo a change. However, if do press it by accident,
it will suspend neovim with no way to get out

https://github.com/neovim/neovim/issues/6660

one easy fix is to add this to your init.vim

```vim
noremap <C-Z> u
```

This will map control Z to 'u' on vim, which is
the shortcut for undoing anyhow. Not that I encourage using
Ctrl Z for undo on nvim, but at least it won't crash nvim
so that you have to restart work!

## 4. Creating a init.vim (.vimrc will have different instructions)

Go to create a init.vim file in:

```powershell
mkdir ~\Appdata\Local\nvim
notepad ~\Appdata\Local\nvim\init.vim
```


## 5. Python and npm support (neovim only)

### WARNING
Some plugins won't work on neovim without python support. However,
i must warn you, trying to get python working on windows with neovim
is quite a pain. It's a very hit or miss thing due to pathing issues 
amongst other things.

Just cause you can get python set up on one windows VM or machine
doesn't mean that other machines are also that easy to setup.

### if you choose to install python anyway...



https://github.com/neovim/pynvim

```powershell
python3 -m pip install --user --upgrade wheel
python3 -m pip install --user --upgrade pynvim
```

For best results, install python from the windows store, through
a MSI installer. You will have pathing issues later on which
can confuse nvim.

You must specify the correct python 
path using the python3_host_prog global variable.

For example:

```powershell
let g:python3_host_prog = 'C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.7_3.7.2544.0_x64__qbz5n2kfra8p0\python.exe' 
```

The path to the binary file is WEIRD, so you got to do it
manually. This is very important for ultisnips 
to work properly.

It's best to do a fresh install of python, wheel and pynvim and restart
if you cannot get this working properly...

TBH i cannot exhaustively debug all the python3 issues though.
Different windows machines have different setups and therefore 
different pathing issues.

It may be best to avoid python altogether.

Otherwise use a python virtual environment. That may produce
consistent results.

#### what not to do:
using one of the following will get a python executable that 
will not work with pynvim in neovim:
```powershell
(get-command Python).Path
(get-command Python3.7).Path
(get-command Python3.10).Path
```
If you try this way,

You may also get a Could not contact PyPI to get latestversion.
ie https request failed error for pynvim.




## 6. Vim Plug

For basic plugins:
https://github.com/junegunn/vim-plug

```powershell
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

```

## 7. Rust and Other LSP support

For language server protocol (LSP) you will need to install
cargo and by extension, rust.

https://doc.rust-lang.org/cargo/getting-started/installation.html

You might also be prompted to install npm:
https://nodejs.org/en/download/



For node.js, after installing node,


```powershell
npm install -g neovim
```
 

## vanilla vim specific

Some conveniences in neovim are not available in vim. 

For example highlight search and incremental search are both disabled
by default in vanilla vim.

Here are a list of how to turn them back on for vanilla vim.
Just add this to your .vimrc

```vim
set incsearch
set hlsearch
```

