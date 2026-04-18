-- return {
--   "nickkadutskyi/jb.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {},
--   config = function()
--     -- require("jb").setup({transparent = true})
--     vim.cmd("colorscheme jb")
--
--     ---------------------------------------------------------
--     --  Tree-sitter dominant highlighting  +  JB.nvim style --
--     ---------------------------------------------------------
--
--     -- Make semantic tokens inherit Tree-sitter's color scheme
--     local function link(from, to)
--       vim.api.nvim_set_hl(0, from, { link = to })
--     end
--
--     -- Operators → look like keywords (Tree-sitter style)
--     link("@lsp.type.operator", "@keyword")
--     link("@lsp.type.operator.cpp", "@keyword.operator")
--
--     -- Variables → follow Tree-sitter's variables
--     link("@lsp.type.variable", "@variable")
--     link("@lsp.type.parameter", "@variable.parameter")
--     link("@lsp.type.property", "@variable.member")
--
--     -- Functions → match Tree-sitter
--     link("@lsp.type.function", "@function")
--     link("@lsp.type.method", "@function.method")
--
--     -- Types → match Tree-sitter type groups
--     link("@lsp.type.class", "@type")
--     link("@lsp.type.struct", "@type")
--     link("@lsp.type.enum", "@type")
--     link("@lsp.type.type", "@type")
--
--     -- Built-in types → Tree-sitter builtin style
--     link("@lsp.type.builtinType", "@type.builtin")
--
--     -- Macros → Tree-sitter's constant style
--     link("@lsp.type.macro", "@constant.macro")
--
--     -- Strings and numbers (clangd usually doesn’t override)
--     link("@lsp.type.string", "@string")
--     link("@lsp.type.number", "@number")
--
--     -- Comments (clangd may send tokens for docs)
--     link("@lsp.type.comment", "@comment")
--
--     -- Namespace → keep using Tree-sitter namespace color
--     link("@lsp.type.namespace", "@namespace")
--
--     -- Disable weird clangd-only groups (better to ignore)
--     vim.api.nvim_set_hl(0, "@lsp.typemod", {})
--     vim.api.nvim_set_hl(0, "@lsp.modifier", {})
--   end,
-- }
--
return {
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "catppuccin",
  --   },
  -- },
  {
    "ember-theme/nvim",
    name = "ember",
    priority = 1000,
    config = function()
      require("ember").setup({
        variant = "ember", -- "ember" | "ember-soft" | "ember-light"
      })
      vim.cmd("colorscheme ember")
    end,
  },
}

-- {
--   "loctvl842/monokai-pro.nvim",
--   lazy = true,
--   config = function()
--     require("monokai-pro").setup({
--       overrideScheme = function(cs, p, config, hp)
--         local cs_override = {}
--
--         -- editor background override
--         cs_override.editor = {
--           background = "#0F1015",
--         }
--
--         -- helpers
--         local color_helper = require("monokai-pro.color_helper")
--         local common_fg = color_helper.lighten(cs.sideBar.foreground, 30)
--
--         -- custom groups
--         cs_override.SnacksPicker = {
--           bg = cs_override.editor.background,
--           fg = common_fg,
--         }
--         cs_override.SnacksPickerBorder = {
--           bg = cs_override.editor.background,
--           fg = cs.tab.unfocusedActiveBorder,
--         }
--         cs_override.SnacksPickerTree = {
--           fg = cs.editorLineNumber.foreground,
--         }
--         cs_override.NonText = {
--           fg = cs.base.dimmed3,
--         }
--         cs_override.SnacksPickerDirectory = { fg = cs.editorLineNumber.foreground }
--
--         return cs_override
--       end,
--     })
--   end,
