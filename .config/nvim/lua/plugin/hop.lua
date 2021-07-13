require('hop').setup {
keys = 'etovxqpdygfblzhckisuran'
}

wk.register({
	['<leader>h'] = { name = '+Hop' },
	['<leader>hh'] = { '<cmd>HopWord<cr>', 'Hop word' },
	['<leader>hp'] = { '<cmd>HopPattern<cr>', 'Hop pattern' },
	['<leader>hc'] = { '<cmd>HopChar1<cr>', 'Hop with 1 key' },
	['<leader>hv'] = { '<cmd>HopChar2<cr>', 'Hop with 2 keys' },
	['<leader>hl'] = { '<cmd>HopLine<cr>', 'Hop line' }
})
