-- =============================================================================
--  __      __________   ______
-- /  \    /  \_____  \ /  __  \
-- \   \/\/   //  ____/ >      <
--  \        //       \/   --   \
--   \__/\  / \_______ \______  /
--        \/          \/      \/
-- lsp.lua --- LSP settings
-- Copyright (c) 2021 Sourajyoti Basak
-- Author: Sourajyoti Basak < wiz28@protonmail.com >
-- URL: https://github.com/wizard-28/dotfiles/
-- License: MIT
-- =============================================================================

-- =============================================================================
-- Mappings
-- =============================================================================
map('n', '<silent> gd', '<cmd>vim.lsp.buf.definition()<CR>')
map('n', '<silent> gD', '<cmd>vim.lsp.buf.declairation()<CR>')
map('n', '<silent> gr', '<cmd>vim.lsp.buf.references()<CR>')
map('n', '<silent> gi', '<cmd>vim.lsp.buf.implementation()<CR>')
map('n', '<silent> K', '<cmd>vim.lsp.buf.hover()<CR>')
map('n', '<silent> <C-k>', '<cmd>vim.lsp.buf.signature_help()<CR>')
map('n', '<silent> <C-p>', '<cmd>vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<silent> <C-n>', '<cmd>vim.lsp.diagnostic.goto_next()<CR>')
-- =============================================================================
-- Auto-format
-- =============================================================================
api.nvim_command 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 100)'

-- =============================================================================
-- LS configurations
-- =============================================================================
local function setup_servers()
	require'lspinstall'.setup()
	local servers = require'lspinstall'.installed_servers()
	for _, server in pairs(servers) do
		require'lspconfig'[server].setup{}

		require'lspconfig'['lua'].setup {
			settings = {
				Lua = {
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = {'vim'},
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file("", true),
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					}
				}
			}
		}
	end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
	setup_servers() -- reload installed servers
	cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
-- =============================================================================
