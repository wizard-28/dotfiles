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
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-compe'
end)
