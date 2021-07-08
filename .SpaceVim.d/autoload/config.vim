function! config#before() abort
  let g:suda_smart_edit = 1 " Enable suda smart buffer switch
endfunction

function! config#after() abort
  set clipboard=unnamedplus " Copy paste between vim and everything else
endfunction
