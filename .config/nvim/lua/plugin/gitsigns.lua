require('gitsigns').setup()

wk.register({
	['<leader>g'] = { name = '+Git Signs' },
	['<leader>gs'] = { '<cmd>lua require"gitsigns".stage_hunk()<cr>', 'Stage hunk' },
	['<leader>gu'] = { '<cmd>lua require"gitsigns".undo_stage_hunk()<cr>', 'Undo stage hunk' },
	['<leader>gr'] = { '<cmd>lua require"gitsigns".reset_hunk()<cr>', 'Reset hunk' },
	['<leader>gR'] = { '<cmd>lua require"gitsigns".reset_buffer()<cr>', 'Reset buffer' },
	['<leader>gp'] = { '<cmd>lua require"gitsigns".preview_hunk()<cr>', 'Preview hunk' },
	['<leader>gb'] = { '<cmd>lua require"gitsigns".blame_line(true)<cr>', 'Blame line' }
})

wk.register({
	['<leader>g'] = { name = '+Git Signs' },
	['<leader>gs'] = { '<cmd>lua require"gitsigns".stage_hunk({fn.line("."), fn.line("v")})<cr>', 'Stage hunk' },
	['<leader>gr'] = { '<cmd>lua require"gitsigns".reset_hunk({fn.line("."), fn.line("v")})<cr>', 'Reset hunk' },
}, { mode = 'v' })
