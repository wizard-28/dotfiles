function! config#before() abort
	let g:suda_smart_edit = 1 " Enable suda smart buffer switch

	"=============================================================================
	" Useless whitespace detection
	"=============================================================================
	highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
	autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
	" match trailing whitespace, except when typing at the end of a line
	autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
	" Show trailing whitespace
	autocmd InsertLeave * match ExtraWhitespace /\s\+$/
	"=============================================================================
endfunction

function! config#after() abort
	set clipboard=unnamedplus " Copy paste between vim and everything else

	"=============================================================================
	" :match settings
	"=============================================================================
	" Show spaces used for indenting (so you use only tabs for indenting).
	nnoremap <leader>ws :match ExtraWhitespace /^\t*\zs \+/<CR>
	" Turn off :match highlighting
	nnoremap <leader>wq :match<CR>
	"=============================================================================

	nmap ss <Plug>Sneak_s
	nmap sS <Plug>Sneak_S
	"=============================================================================
	" FZF settings
	"=============================================================================
	map <C-f> :Files<CR>
	map <C-h> :History<CR>
	map <C-g> :RG<CR>
	map <C-s> :BLines<CR>
	map <C-a> :Lines<CR>
	map <C-b> :Buffers<CR>
	nnoremap <leader>ff :Files<CR>
	nnoremap <leader>fH :History <CR>
	nnoremap <leader>fg :Rg<CR>
	nnoremap <leader>fb :BLines <CR>
	nnoremap <leader>fa :Lines <CR>
	nnoremap <leader>fb :Buffers<CR>
	nnoremap <leader>fm :Marks<CR>
	let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
	let $FZF_DEFAULT_COMMAND="rg --files --hidden"
	"Get Files
	command! -bang -nargs=? -complete=dir Files
				\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

	" Get text in files with Rg
	command! -bang -nargs=* Rg
				\ call fzf#vim#grep(
				\   'rg --column --line-number --no-heading --hidden --color=always --smart-case '.shellescape(<q-args>), 1,
				\   fzf#vim#with_preview(), <bang>0)

	" Ripgrep advanced
	function! RipgrepFzf(query, fullscreen)
		let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
		let initial_command = printf(command_fmt, shellescape(a:query))
		let reload_command = printf(command_fmt, '{q}')
		let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
		call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
	endfunction

	command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

	" Git grep
	command! -bang -nargs=* GGrep
				\ call fzf#vim#grep(
				\   'git grep --line-number '.shellescape(<q-args>), 0,
				\   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
	"=============================================================================
endfunction
