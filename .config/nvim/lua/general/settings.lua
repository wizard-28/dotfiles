-- =============================================================================
--  __      __________   ______
-- /  \    /  \_____  \ /  __  \
-- \   \/\/   //  ____/ >      <
--  \        //       \/   --   \
--   \__/\  / \_______ \______  /
--        \/          \/      \/
-- settings.lua --- settings for vim
-- Copyright (c) 2021 Sourajyoti Basak
-- Author: Sourajyoti Basak < wiz28@protonmail.com >
-- URL: https://github.com/wizard-28/dotfiles/
-- License: MIT
-- =============================================================================

-- =============================================================================
-- Global variables
-- =============================================================================
g.mapleader = ' '		-- Map leader to <Space>
-- =============================================================================

-- =============================================================================
-- Settings
-- =============================================================================
cmd 'colorscheme gruvbox'	-- Gruvbox baby
opt.termguicolors = true	-- Needed by gruvbox.lua

opt.relativenumber = true	-- Relative numbers
opt.mouse = 'a'			-- Mouse support
opt.wrap = false		-- No line wrapping
opt.clipboard = 'unnamedplus'	-- Universal clipboard
opt.splitbelow = true		-- Horizontal splits will be below
opt.splitright = true		-- Vertical splits will be right 
opt.cursorline = true		-- Highlight cursor horizontally
-- =============================================================================