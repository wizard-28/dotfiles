local lazy = require "lazy"
local utils = require "astronvim.utils"
local updater = require "astronvim.utils.updater"

return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    return require("astronvim.utils").extend_tbl(opts, {
      config = {
        layout = {
          { type = "padding", val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) } },
          {
            type = "text",
            val = {
              " █████  ███████ ████████ ██████   ██████",
              "██   ██ ██         ██    ██   ██ ██    ██",
              "███████ ███████    ██    ██████  ██    ██",
              "██   ██      ██    ██    ██   ██ ██    ██",
              "██   ██ ███████    ██    ██   ██  ██████",
              " ",
              "    ███    ██ ██    ██ ██ ███    ███",
              "    ████   ██ ██    ██ ██ ████  ████",
              "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
              "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
              "    ██   ████   ████   ██ ██      ██",
            },
            opts = { position = "center", hl = "DashboardHeader" },
          },
          { type = "padding", val = 5 },
          {
            type = "group",
            val = {
              utils.alpha_button("LDR f f", "  Find File  "),
              utils.alpha_button("LDR s p", "  Open Project  "),
              utils.alpha_button("LDR f o", "  Recents  "),
              utils.alpha_button("LDR f w", "  Find Word  "),
              utils.alpha_button("LDR f n", "  New File  "),
              utils.alpha_button("LDR f m", "  Bookmarks  "),
              utils.alpha_button("LDR S l", "  Last Session  "),
            },
            opts = { spacing = 1 },
          },
          { type = "padding", val = 5 },
          {
            type = "text",
            val = {
              " AstroNvim " .. updater.version(true),
            },
            opts = { position = "center", hl = "DashboardFooter" },
          },
          {
            type = "text",
            val = {
              "Loaded " .. lazy.stats().loaded .. " out of " .. lazy.stats().count .. " plugins ",
            },
            opts = { position = "center", hl = "DashboardFooter" },
          },
        },
        opts = { noautocmd = true },
      },
    })
  end,
}
