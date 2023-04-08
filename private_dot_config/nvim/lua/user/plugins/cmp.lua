return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-emoji",
    "kdheepak/cmp-latex-symbols",
    "Saecki/crates.nvim",
    "jcdickinson/codeium.nvim",
  },
  opts = function(_, opts)
    local cmp = require "cmp"
    return require("astronvim.utils").extend_tbl(opts, {
      sources = cmp.config.sources {
        { name = "nvim_lsp", priority = 1000 },
        { name = "crates" },
        { name = "luasnip", priority = 750 },
        { name = "codeium", priority = 1000 },
        { name = "latex_symbols", priority = 700 },
        { name = "emoji", priority = 700 },
        { name = "calc", priority = 650 },
        { name = "path", priority = 500 },
        { name = "buffer", priority = 250 },
      },
      format = require("lspkind").cmp_format {
        mode = "symbol",
        maxwidth = 50,
        ellipsis_char = "...",
        symbol_map = { Codeium = "" },
      },
    })
  end,
}
