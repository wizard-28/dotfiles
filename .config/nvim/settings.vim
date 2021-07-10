"=============================================================================
"  __      __________   ______  
" /  \    /  \_____  \ /  __  \ 
" \   \/\/   //  ____/ >      < 
"  \        //       \/   --   \
"   \__/\  / \_______ \______  /
"        \/          \/      \/
" settings.vim --- settings for vim
" Copyright (c) 2021 Sourajyoti Basak
" Author: Sourajyoti Basak < wiz28@protonmail.com >
" URL: https://github.com/wizard-28/dotfiles/
" License: MIT
"=============================================================================

"=============================================================================
" Global variables
"=============================================================================
let g:mapleader = "\<Space>"
"=============================================================================

"=============================================================================
" Settings
"=============================================================================
syntax enable
colorscheme gruvbox
filetype plugin indent on	" Indents

set nocompatible		" Be iMproved
set relativenumber		" Relative numbers
set mouse=a			" Enable mouse support
set nowrap			" Display long lines as just one line
set clipboard=unnamedplus	" Copy paste between vim and everything else
set splitbelow			" Horizontal splits will be below
set splitbelow			" Vertical splits will be right
set cursorline			" Highlighting cursor horizontally
