-- =d============================================================================
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
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fg', '<cmd>Telescope git_files<CR>')
map('n', '<leader>fr', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fb', '<cmd>Telescope current_buffer_fuzzy_find<CR>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
-- =============================================================================
-- Settings
-- =============================================================================
require('telescope').setup {
	defaults = {
		vimgrep_arguments = {
			'rg',
			'--hidden',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case'
		}
	}
}
require('lspsaga').init_lsp_saga()
