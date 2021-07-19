--- =============================================================================
--  __      __________   ______
-- /  \    /  \_____  \ /  __  \
-- \   \/\/   //  ____/ >      <
--  \        //       \/   --   \
--   \__/\  / \_______ \______  /
--        \/          \/      \/
-- lint.lua --- nvim-lint configuration
-- Copyright (c) 2021 Sourajyoti Basak
-- Author: Sourajyoti Basak < wiz28@protonmail.com >
-- URL: https://github.com/wizard-28/dotfiles/
-- License: MIT
-- =============================================================================

-- =============================================================================
-- Set linters
-- =============================================================================
require('lint').linters_by_ft = {
	sh = { 'shellcheck' }
}
-- =============================================================================
-- Set autocmd
-- =============================================================================
cmd 'au BufEnter,TextChanged,TextChangedI * lua require(\'lint\').try_lint()'
-- =============================================================================
