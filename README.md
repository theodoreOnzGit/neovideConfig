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


## 4. Creating a init.vim (.vimrc will have different instructions)

Go to create a init.vim file in:

```powershell
mkdir ~\Appdata\Local\nvim
notepad ~\Appdata\Local\nvim\init.vim
```


## 5. Python support (neovim only)

Most plugins won't work on neovim without python support:

https://github.com/neovim/pynvim

```powershell
python3 -m pip install --user --upgrade pynvim
```

You must specify the correct python 
path using

```powershell
let g:python3_host_prog = 'C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.7_3.7.2544.0_x64__qbz5n2kfra8p0\python.exe' 
```

The path to the binary file is WEIRD, so you got to do it
manually. This is very important for ultisnips 
to work pro perly.
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




