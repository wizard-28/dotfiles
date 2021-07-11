cmd 'packadd packer.nvim'

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use {
		"npxbr/gruvbox.nvim",
		requires = {"rktjmp/lush.nvim"}
	}	-- Gurvbox baby
	use {
		'nvim-telescope/telescope.nvim',
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	}	-- Telescope
	use 'neovim/nvim-lspconfig'		-- LSP
	use 'hrsh7th/nvim-compe'		-- Completion

	use 'kyazdani42/nvim-web-devicons'	-- Icons
end)
