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

-- =============================================================================
-- Bootstrap packer
-- =============================================================================
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  cmd 'packadd packer.nvim'
end
-- =============================================================================

return require('packer').startup(function(use)
	use { 'wbthomason/packer.nvim' }

	-- General
	use {
		'sainnhe/gruvbox-material',
		setup = function()
			g.gruvbox_material_enable_italic = true
			g.gruvbox_material_enable_bold = true
			g.gruvbox_material_better_performance = true
			g.gruvbox_material_palette = 'original'
		end,
		config = function()
			cmd 'colorscheme gruvbox-material'
		end
	}
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
		event = 'VimEnter',
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
		'mbbill/undotree',
		cmd = 'UndotreeToggle',
		setup = function()
			g.undotree_WindowLayout = 4
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
		'a-vrma/black-nvim',
		ft = 'python',
		config = function()
			cmd("au FileType python au BufWritePre <buffer> call Black()")
		end
	}
	use {
		'andymass/vim-matchup',
		event = 'CursorMoved',
		setup = function()
			g.loaded_matchit = 1
		end
	}
	use {
		'glepnir/dashboard-nvim',
		setup = function()
			require('plugin.dashboard')
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
			require('gitsigns').setup()
		end
	}
	use {
		'TimUntersberger/neogit',
		cmd = 'Neogit',
		requires = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
		config = function()
			require('neogit').setup {
				integrations = {
					diffview = true
				}
			}
		end
	}
	use 'samoshkin/vim-mergetool'

	-- LSP
	use {
		'neovim/nvim-lspconfig',
		event = 'BufReadPre',
		requires = {
			'kabouzeid/nvim-lspinstall',
			{
				'glepnir/lspsaga.nvim',
				event = 'BufReadPost',
				config = function()
					require('lspsaga').init_lsp_saga()
				end
			},
			{
				'folke/lua-dev.nvim',
				module = 'lua-dev',
				ft = 'lua'
			}
		},
		config = function()
			require('plugin.lsp')
		end
	}
	use {
		'hrsh7th/nvim-compe',
		event = 'InsertEnter',
		config = function()
			require('plugin.compe')
		end,
		requires = {
			'L3MON4D3/LuaSnip',
			{
				'rafamadriz/friendly-snippets',
				config = function()
					require("luasnip/loaders/from_vscode").lazy_load()
				end
			},
			{
				'windwp/nvim-autopairs',
				config = function()
					require('nvim-autopairs').setup {}
				end
			}
		}
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
