"=============================================================================
"  __      __________   ______   
" /  \    /  \_____  \ /  __  \  neomake.vim --- Neomake configuration
" \   \/\/   //  ____/ >      <  Copyright (c) 2021 Sourajyoti Basak
"  \        //       \/   --   \ Author: Sourajyoti Basak < wiz28@protonmail.com >
"   \__/\  / \_______ \______  / URL: https://github.com/wizard-28/dotfiles/
"        \/          \/      \/  License: MIT
"=============================================================================

function! Is_On_Battery()
	return readfile('/sys/class/power_supply/ACAD/online') == ['0']
endfunction

if Is_On_Battery()
	call neomake#configure#automake('w')
else
	call neomake#configure#automake('nw', 1000)
endif
