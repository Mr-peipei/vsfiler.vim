# vsfiler.vim

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## Concept

This filer is so light and intuitive.  
You don't have to remember too many keemapings.  
This filer will deliver the simplest vertically divided filer in the world.  

## Images

![Screenshot_20220224_205900](https://user-images.githubusercontent.com/54967427/155520021-cd4b5c52-3f3a-4055-be1d-ae3b8ebc7efb.png)

## Installation

Use your favorite plugin manager to install this plugin. [tpope/vim-pathogen](https://github.com/tpope/vim-pathogen), [VundleVim/Vundle.vim](https://github.com/VundleVim/Vundle.vim), [junegunn/vim-plug](https://github.com/junegunn/vim-plug), and [Shougo/dein.vim](https://github.com/Shougo/dein.vim) are some of the more popular ones. A lengthy discussion of these and other managers can be found on [vi.stackexchange.com](https://vi.stackexchange.com/questions/388/what-is-the-difference-between-the-vim-plugin-managers). Basic instructions are provided below, but please **be sure to read, understand, and follow all the safety rules that come with your ~~power tools~~ plugin manager.**

If you have no favorite, or want to manage your plugins without 3rd-party dependencies, consider using Vim 8+ packages, as described in Greg Hurrell's excellent Youtube video: [Vim screencast #75: Plugin managers](https://www.youtube.com/watch?v=X2_R3uxDN6g).

<details>
<summary>Pathogen</summary>
Pathogen is more of a runtime path manager than a plugin manager. You must clone the plugins' repositories yourself to a specific location, and Pathogen makes sure they are available in Vim.


1. In the terminal,
    ```bash
    git clone https://github.com/Mr-peipei/vsfiler.vim.git ~/.vim/bundle/vsfiler.vim
    ```
1. In your `vimrc`,
    ```vim
    call pathogen#infect()
    syntax on
    filetype plugin indent on
    ```
1. Restart Vim, and run `:helptags ~/.vim/bundle/vsfiler.vim/doc/` or `:Helptags`.
</details>

<details>
  <summary>Vundle</summary>

1. Install Vundle, according to its instructions.
1. Add the following text to your `vimrc`.
    ```vim
    call vundle#begin()
      Plugin 'Mr-peipei/vsfiler.vim'
    call vundle#end()
    ```
1. Restart Vim, and run the `:PluginInstall` statement to install your plugins.
</details>

<details>
  <summary>Vim-Plug</summary>

1. Install Vim-Plug, according to its instructions.
1. Add the following text to your `vimrc`.
```vim
call plug#begin()
  Plug 'Mr-peipei/vsfiler.vim'
call plug#end()
```
1. Restart Vim, and run the `:PlugInstall` statement to install your plugins.
</details>

<details>
  <summary>Dein</summary>

1. Install Dein, according to its instructions.
1. Add the following text to your `vimrc`.
    ```vim
    call dein#begin()
      call dein#add('Mr-peipei/vsfiler.vim')
    call dein#end()
    ```
1. Restart Vim, and run the `:call dein#install()` statement to install your plugins.
</details>

<details>
<summary>Vim 8+ packages</summary>

If you are using Vim version 8 or higher you can use its built-in package management; see `:help packages` for more information. Just run these commands in your terminal:

```bash
git clone https://github.com/Mr-peipei/vsfiler.vim.git ~/.vim/pack/vendor/start/vsfiler.vim
vim -u NONE -c "helptags ~/.vim/pack/vendor/start/vsfiler.vim/doc" -c q
```
</details>

## Usaga

Keymapping is so simple.
Below is the default keymappings.

```
nnoremap <silent><C-m> :<c-u>call vsfiler#initv()<cr>

if !hasmapto('<plug>(vsfiler-open)')
  nmap <buffer> l <plug>(vsfiler-open)
  nmap <buffer> h <plug>(vsfiler-up)
  nmap <buffer> K <plug>(vsfiler-newdir)
  nmap <buffer> N <plug>(vsfiler-newfile)
  nmap <buffer> D <plug>(vsfiler-deletedir)
  nmap <buffer> <C-m> <plug>(vsfiler-close)
endif

```

## INSPIRED

This vim plugin is inspire by [mattn/vim-molder](https://github.com/mattn/vim-molder) and [lambdalisue/fern.vim](https://github.com/lambdalisue/fern.vim)
Thank you for yours oss contribution.
