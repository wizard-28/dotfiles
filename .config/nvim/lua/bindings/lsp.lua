local M = {}

function M.Set_Keymaps(client)
	wk.register({
		['<leader>g'] = { name = '+LSP' },
		['<leader>gh'] = { '<cmd>Lspsaga lsp_finder<cr>', 'Find definitions and references' },
		['<leader>gc'] = { '<cmd>Lspsaga preview_definition<cr>', 'Preview definition' },
		['K'] = { '<cmd>Lspsaga hover_doc<cr>', 'Hover' },
		['<C-f>'] = { '<cmd> lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<cr>', 'Scroll down' },
		['<C-b>'] = { '<cmd> lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<cr>', 'Scroll up' },
		['<leader>gs'] = { '<cmd>Lspsaga signature_help<cr>', 'Signature help' },
		['<leader>gd'] = { '<cmd>Lspsaga show_line_diagnostics<cr>', 'Show line diagnostics' },
		['[e'] = { '<cmd>Lspsaga diagnostic_jump_prev<cr>', 'Jump to previous diagnosis' },
		[']e'] = { '<cmd>Lspsaga diagnostic_jump_prev<cr>', 'Jump to next diagnosis' }
	})

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		wk.register({
			['<leader>gf'] = { '<cmd>lua vim.lsp.buf.formatting()<cr>', 'Format document' }
		})
	elseif client.resolved_capabilities.document_range_formatting then
		wk.register({
			['<leader>gf'] = { '<cmd>lua vim.lsp.buf.range_formatting()<cr>', 'Format document' }
		})
	end
end

return M
