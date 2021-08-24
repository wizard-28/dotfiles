local ts = require('nvim-treesitter.configs')
ts.setup {
	ensure_installed = {
		"bash",
		"python",
		"lua",
		"c",
		"fish"
	},
	highlight = {
		enable = true,					-- Enable highlighting
		additional_vim_regex_highlighting = true	-- Spellcheck fix

	},
	indent = {
		enable = true
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-n>",
			node_incremental = "<C-n>",
			scope_incremental = "<C-s>",
			node_decremental = "<C-m>",
		}
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['ac'] = '@class.outer',
				['ic'] = '@class.inner'
			}
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},
	matchup = {
		enable = true
	}
}
