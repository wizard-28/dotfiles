wk.register({
	['<leader>h'] = { name = '+Git Signs' },
	['<leader>hs'] = { '<cmd>lua require"gitsigns".stage_hunk()<cr>', 'Stage hunk' },
	['<leader>hS'] = { '<cmd>lua require"gitsigns".stage_hunk()<cr>', 'Stage buffer' },
	['<leader>hu'] = { '<cmd>lua require"gitsigns".undo_stage_hunk()<cr>', 'Undo stage hunk' },
	['<leader>hU'] = { '<cmd>lua require"gitsigns".undo_stage_hunk()<cr>', 'Undo buffer index' },
	['<leader>hr'] = { '<cmd>lua require"gitsigns".reset_hunk()<cr>', 'Reset hunk' },
	['<leader>hR'] = { '<cmd>lua require"gitsigns".reset_buffer()<cr>', 'Reset buffer' },
	['<leader>hp'] = { '<cmd>lua require"gitsigns".preview_hunk()<cr>', 'Preview hunk' },
	['<leader>hb'] = { '<cmd>lua require"gitsigns".blame_line(true)<cr>', 'Blame line' }
})

wk.register({
	['<leader>h'] = { name = '+Git Signs' },
	['<leader>hs'] = { '<cmd>lua require"gitsigns".stage_hunk({fn.line("."), fn.line("v")})<cr>', 'Stage hunk' },
	['<leader>hr'] = { '<cmd>lua require"gitsigns".reset_hunk({fn.line("."), fn.line("v")})<cr>', 'Reset hunk' },
}, { mode = 'v' })
