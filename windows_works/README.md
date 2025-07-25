Some quick tips to prevent annoyances:
## latest version of nvim required

For some of the lsp features, you need an updated version of neovim.

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt install neovim
```


## Checkhealth

For debug purposes, use :checkhealth in order to check for any debugging needed.

## TSInstall

When opening new lua or markdown files, it is common to encounter treesitter errors

use:
```
TSInstall lua 
```
and
```
TSInstall markdown 
```
to prevent code execution errors

## lua and luarocks

use checkhealth to 

While this config just works on windows, I used it for linux mint also.
For lua dependencies...:

```
sudo apt install lua5.1 luarocks
```
