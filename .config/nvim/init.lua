-- =============================================================================
--  __      __________   ______
-- /  \    /  \_____  \ /  __  \
-- \   \/\/   //  ____/ >      <
--  \        //       \/   --   \
--   \__/\  / \_______ \______  /
--        \/          \/      \/
-- init.lua --- Initialization file for Vim
-- Copyright (c) 2021 Sourajyoti Basak
-- Author: Sourajyoti Basak < wiz28@protonmail.com >
-- URL: https://github.com/wizard-28/dotfiles/
-- License: MIT
-- =============================================================================

-- =============================================================================
-- Aliases
cmd = vim.cmd 	-- alias for executing Vim commands
fn = vim.fn	-- alias for calling Vim functions
g = vim.g	-- alias to access global variables
opt = vim.opt	-- alias to set options
-- =============================================================================

-- =============================================================================
-- Helper functions
-- =============================================================================
-- Function to set mappings
function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
-- =============================================================================

-- =============================================================================
-- Sources
-- =============================================================================
require('plugins')
require('settings')
require('plugins_conf')
-- =============================================================================
