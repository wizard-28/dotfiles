local ts = require('nvim-treesitter.configs')
ts.setup {
	highlight = {
		enable = true,					-- Enable highlighting
		additional_vim_regex_highlighting = true	-- Spellcheck fix

	},
	indent = {
		enable = true
	},
	incremental_selection = {
		enable = true
	}
}
