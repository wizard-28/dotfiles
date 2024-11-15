---@diagnostic disable: missing-fields
return {
  "hrsh7th/nvim-cmp",
  -- Replicate `atom_colored` nvim-cmp from NVChad.
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    opts.window = {
      completion = {
        side_padding = 0,
        winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
        scrollbar = false,
      },
    }
    opts.formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(_, item)
        local icons = {
          Namespace = "󰌗",
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰆧",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈚",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "󰊄",
          Table = "",
          Object = "󰅩",
          Tag = "",
          Array = "[]",
          Boolean = "",
          Number = "",
          Null = "󰟢",
          String = "󰉿",
          Calendar = "",
          Watch = "󰥔",
          Package = "",
          Copilot = "",
          Codeium = "",
          TabNine = "",
        }
        local icon = icons[item.kind]

        icon = " " .. icon .. " "
        item.menu = "   (" .. item.kind .. ")"
        item.kind = icon

        return item
      end,
    }
  end,
}
