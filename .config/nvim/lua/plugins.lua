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
return require('packer').startup(function(use)
	use { 'wbthomason/packer.nvim' }

	-- General
	use 'sainnhe/gruvbox-material'
	use {
		'nvim-telescope/telescope.nvim',
		config = function()
			require('plugin.telescope')
		end,
		cmd = 'Telescope',
		module = { 'telescope', 'plugin.telescope' },
		keys = '<leader>f',
		requires = {
			{
				'nvim-lua/popup.nvim',
				module = 'popup',
			},
			{
				'nvim-lua/plenary.nvim',
				module = 'plenary',
			},
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				opt = true,
				run = 'make'
			}
		}
	}
	use {
		"folke/which-key.nvim",
		event = 'BufReadPre',
		config = function()
			require('bindings.init')
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
		event = 'BufWinEnter',
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
		event = 'BufReadPost',
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
			'kabouzeid/nvim-lspinstall',
		}, {
				'glepnir/lspsaga.nvim',
				event = 'BufReadPost',
				config = function()
					require('lspsaga').init_lsp_saga()
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
	use {
		'L3MON4D3/LuaSnip',
		event = 'InsertEnter',
	}
	use {
		'mfussenegger/nvim-lint',
		ft = 'sh',
		config = function()
			require('plugin.lint')
		end
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require('plugin.treesitter')
		end,
		requires = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		}
	}
end)
