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

## Instaling Nvim

```powershell
winget install Neovim.Neovim
```

## Instaling git

```powershell
winget install -e --id Git.Git
```


## installing neovide

Go here:
https://github.com/neovide/neovide/releases/tag/0.10.1


## Creating a init.vim (.vimrc will have different instructions)

Go to create a init.vim file in:

```powershell
mkdir ~\Appdata\Local\nvim
notepad ~\Appdata\Local\nvim\init.vim
```

## Vim Plug

For basic plugins:
https://github.com/junegunn/vim-plug

```powershell
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

```






