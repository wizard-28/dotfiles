-- keymaps
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }
	buf_set_keymap('n', 'gh', '<Cmd>Lspsaga lsp_finder<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>Lspsaga preview_definition<CR>', opts)

	buf_set_keymap('n', '<leader>ca', '<Cmd>Lspsaga code_action<CR>', opts)

	buf_set_keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
	buf_set_keymap('n', '<C-f>', '<Cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<CR>', opts)
	buf_set_keymap('n', '<C-b>', '<Cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<CR>', opts)

	buf_set_keymap('n', 'gs', '<cmd>Lspsaga signature_help<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>Lspsaga rename<CR>', opts)

	buf_set_keymap('n', '<leader>cd', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)

	buf_set_keymap('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
	buf_set_keymap('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.resolved_capabilities.document_range_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end

	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec([[
		augroup lsp_document_highlight
		autocmd! * <buffer>
		autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
		autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		augroup END
			]], false)
	end
end

-- Configure lua language server for neovim development
local lua_settings = {
	Lua = {
		runtime = {
			-- LuaJIT in the case of Neovim
			version = 'LuaJIT',
			path = vim.split(package.path, ';'),
		},
		diagnostics = {
			-- Get the language server to recognize the `vim` global
			globals = {'vim'},
		},
		workspace = {
			-- Make the server aware of Neovim runtime files
			library = {
				[vim.fn.expand('$VIMRUNTIME/lua')] = true,
				[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
			},
		},
	}
}

-- config that activates keymaps and enables snippet support
local function make_config()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			'documentation',
			'detail',
			'additionalTextEdits'
		}
	}
	return {
		-- enable snippet support
		capabilities = capabilities,
		-- map buffer local keybindings when the language server attaches
		on_attach = on_attach,
	}
end

-- lsp-install
local function setup_servers()
	require'lspinstall'.setup()

	-- get all installed servers
	local servers = require'lspinstall'.installed_servers()
	-- ... and add manually installed servers
	table.insert(servers, "clangd")
	table.insert(servers, "sourcekit")

	for _, server in pairs(servers) do
		local config = make_config()

		-- language specific config
		if server == "lua" then
			config.settings = lua_settings
		end
		if server == "sourcekit" then
			config.filetypes = {"swift", "objective-c", "objective-cpp"}; -- we don't want c and cpp!
		end
		if server == "clangd" then
			config.filetypes = {"c", "cpp"}; -- we don't want objective-c and objective-cpp!
		end

		require'lspconfig'[server].setup(config)
	end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
	setup_servers() -- reload installed servers
	vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end