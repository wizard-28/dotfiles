"=============================================================================
"  __      __________   ______   
" /  \    /  \_____  \ /  __  \  fzf.vim --- FZF configuration
" \   \/\/   //  ____/ >      <  Copyright (c) 2021 Sourajyoti Basak
"  \        //       \/   --   \ Author: Sourajyoti Basak < wiz28@protonmail.com >
"   \__/\  / \_______ \______  / URL: https://github.com/wizard-28/dotfiles/
"        \/          \/      \/  License: MIT
"=============================================================================

"=============================================================================
" Options
"=============================================================================
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"
let g:which_key_map.f = { 'name': '+fzf' }
"=============================================================================

"=============================================================================
" Mappings
"=============================================================================
nnoremap <leader>ff :Files<CR>
let g:which_key_map.f.f = 'search-files'

nnoremap <leader>fg :GFiles<CR>
let g:which_key_map.f.g = 'search-git-files'

nnoremap <leader>fb :BLines<CR>
let g:which_key_map.f.b = 'search-current-buffer-lines'

nnoremap <leader>fl :Lines<CR>
let g:which_key_map.f.l = 'search-all-buffer-files'

nnoremap <leader>fr :Rg<CR>
let g:which_key_map.f.r = 'search-every-line'

nnoremap <leader>fh :History<CR>
let g:which_key_map.f.h = 'search-history'
"=============================================================================
