--- =============================================================================
--  __      __________   ______
-- /  \    /  \_____  \ /  __  \
-- \   \/\/   //  ____/ >      <
--  \        //       \/   --   \
--   \__/\  / \_______ \______  /
--        \/          \/      \/
-- plugins.lua --- List of plugins
-- Copyright (c) 2021 Sourajyoti Basak
-- Author: Sourajyoti Basak < wiz28@protonmail.com >
-- URL: https://github.com/wizard-28/dotfiles/
-- License: MIT
-- =============================================================================

cmd 'packadd packer.nvim'

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'		-- Packer itself
	-- =============================================================================
	-- General
	-- =============================================================================
	-- Colorscheme
	use { "npxbr/gruvbox.nvim", requires = { "rktjmp/lush.nvim" }}

	use {
		'nvim-telescope/telescope.nvim',
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }}
	}	-- Telescope

	-- Which key
	use { "folke/which-key.nvim", config = function() require("which-key").setup {} end }
	-- =============================================================================

	-- =============================================================================
	-- LSP
	-- =============================================================================
	use 'neovim/nvim-lspconfig'		-- LSP
	use 'kabouzeid/nvim-lspinstall'		-- LSP installation helper
	use 'glepnir/lspsaga.nvim'		-- LSP Bling
	-- Completions
	use { 'hrsh7th/nvim-compe', config = [[require('ftplugin.compe')]], event = 'InsertEnter *' }
	-- Snippets
	use 'L3MON4D3/LuaSnip'
	-- Supplementary linting
	use { 'mfussenegger/nvim-lint', ft = { 'sh' }, config = [[require('ftplugin.lint')]] }
	-- =============================================================================

	-- =============================================================================
	-- Style
	-- =============================================================================
	-- Treesitter
	use { 'nvim-treesitter/nvim-treesitter', ft = { 'sh', 'lua' }, config = [[require('plugin.treesitter')]], run = ':TSUpdate' }
	-- Statusline
	use { 'beauwilliams/statusline.lua', requires = { 'kosayoda/nvim-lightbulb' }}
	use 'kyazdani42/nvim-web-devicons'	-- Icons
	-- =============================================================================
end)
