-- =============================================================================
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
	use { 'wbthomason/packer.nvim', opt = true }		-- Packer itself

	-- General
	use 'sainnhe/gruvbox-material'
	use {
		'nvim-telescope/telescope.nvim',
		config = function()
			require('plugin.telescope')
		end,
		cmd = { 'Telescope' },
		keys = { '<leader>f' },
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'},
			{'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }}
	}
	use {
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup {}
		end
	}
	use {
		'ggandor/lightspeed.nvim',
		keys = { 's', 'S' }
	}
	use {
		'lambdalisue/suda.vim',
		setup = function()
			g.suda_smart_edit = true
		end
	}
	use {
		'lukas-reineke/indent-blankline.nvim',
		event = 'BufReadPre',
		setup = function()
			require('plugin.blankline')
		end
	}
	use {
		'beauwilliams/statusline.lua',
		requires = {
			'kosayoda/nvim-lightbulb',
			'kyazdani42/nvim-web-devicons'
		}
	}

	-- Git
	use {
		'lewis6991/gitsigns.nvim',
		event = 'BufReadPre',
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			require('plugin.gitsigns')
		end
	}
	use {
		'TimUntersberger/neogit',
		cmd = 'Neogit',
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			require('neogit').setup {}
		end
	}

	-- LSP
	use {
		'neovim/nvim-lspconfig',
		event = 'BufReadPre',
		requires = {{
			'kabouzeid/nvim-lspinstall'
		}, {
				'glepnir/lspsaga.nvim',
				config = function()
					require('plugin.lspsaga')
				end
			}},
		config = function()
			require('plugin.lsp')
		end
	}
	use {
		'hrsh7th/nvim-compe',
		event = 'InsertEnter',
		config = function()
			require('plugin.compe')
		end
	}
	use 'L3MON4D3/LuaSnip'
	use {
		'mfussenegger/nvim-lint',
		ft = 'sh',
		config = function()
			require('plugin.lint')
		end
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		ft = { 'sh', 'lua' },
		run = ':TSUpdate',
		config = function()
			require('plugin.treesitter')
		end
	}
end)
