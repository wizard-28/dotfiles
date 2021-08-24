--- =============================================================================
--  __      __________   ______
-- /  \    /  \_____  \ /  __  \
-- \   \/\/   //  ____/ >      <
--  \        //       \/   --   \
--   \__/\  / \_______ \______  /
--        \/          \/      \/
-- compe.lua --- Configuration for nvim-compe
-- Copyright (c) 2021 Sourajyoti Basak
-- Author: Sourajyoti Basak < wiz28@protonmail.com >
-- URL: https://github.com/wizard-28/dotfiles/
-- License: MIT
-- =============================================================================
require'compe'.setup {
	enabled = true;
	autocomplete = true;
	debug = false;
	min_length = 1;
	preselect = 'enable';
	throttle_time = 80;
	source_timeout = 200;
	incomplete_delay = 400;
	max_abbr_width = 100;
	max_kind_width = 100;
	max_menu_width = 100;
	documentation = {
		border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
		winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
		max_width = 120,
		min_width = 60,
		max_height = math.floor(vim.o.lines * 0.3),
		min_height = 1,
	};

	source = {
		path = true;
		buffer = {
			priority = 100
		};
		calc = true;
		nvim_lsp = true;
		nvim_lua = true;
		spell = true;
		tags = true;
		luasnip = true;
		treesitter = true;
	};
}
local t = function(str)
	return api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
	local col = fn.col('.') - 1
	if col == 0 or fn.getline('.'):sub(col, col):match('%s') then
		return true
	else
		return false
	end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
	if fn.pumvisible() == 1 then
		return t "<C-n>"
	elseif require'luasnip'.expand_or_jumpable() then
		return t "<cmd> lua require'luasnip'.jump(1)<cr>"
	elseif check_back_space() then
		return t "<Tab>"
	else
		return fn['compe#complete']()
	end
end
_G.s_tab_complete = function()
	if fn.pumvisible() == 1 then
		return t "<C-p>"
	  elseif require'luasnip'.jumpable(-1) then
		return t "<cmd> lua require'luasnip'.jump(-1)<cr>"
	else
		-- If <S-Tab> is not working in your terminal, change it to <C-h>
		return t "<S-Tab>"
	end
end

-- Map tab to the above tab complete functions
api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- Map compe confirm and complete functions
api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })
