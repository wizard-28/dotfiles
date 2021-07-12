-- =============================================================================
--  __      __________   ______
-- /  \    /  \_____  \ /  __  \
-- \   \/\/   //  ____/ >      <
--  \        //       \/   --   \
--   \__/\  / \_______ \______  /
--        \/          \/      \/
-- telescope.lua --- telescope.nvim customization file
-- Copyright (c) 2021 Sourajyoti Basak
-- Author: Sourajyoti Basak < wiz28@protonmail.com >
-- URL: https://github.com/wizard-28/dotfiles/
-- License: MIT
-- =============================================================================

-- =============================================================================
-- Key maps
-- =============================================================================
wk.register({
	['<leader>f'] = { name = '+Fuzzy Find' },
	['<leader>ff'] = { '<cmd>Telescope find_files<cr>', 'Find file' },
	['<leader>fg'] = { '<cmd>Telescope git_files<cr>', 'Find git file' },
	['<leader>fr'] = { '<cmd>Telescope live_grep<cr>', 'Grep every line in current directory' },
	['<leader>fb'] = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Grep every line in current buffer' },
	['<leader>fh'] = { '<cmd>Telescope help_tags<cr>', 'Help tags' },

	['<leader>fv'] = { '<cmd>lua require("plugin.telescope").search_dotfiles()<cr>', 'Browse vim configuration' }
})
-- =============================================================================

-- =============================================================================
-- Settings
-- =============================================================================
require('telescope').setup {
	defaults = {
		file_sorter = require('telescope.sorters').get_fzy_sorter,
		vimgrep_arguments = {
			'rg',
			'--hidden',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case'
		},
		file_ignore_patterns = {
			'.git/*'
		}
	},
	extentions = {
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = false, -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
		}
	}
}

require('telescope').load_extension('fzf')

local M = {}
M.search_dotfiles = function()
	require('telescope.builtin').find_files({
	prompt_title = 'Vim Configuration',
	cwd = '~/dotfiles/.config/nvim/',
	hidden = true
})
end

return M
