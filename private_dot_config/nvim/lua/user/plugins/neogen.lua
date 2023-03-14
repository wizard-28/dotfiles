return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  module = "neogen",
  cmd = "Neogen",
  config = function()
    require("neogen").setup {
      snippet_engine = "luasnip",
      languages = {
        rust = { template = { annotation_convention = "rustdoc" } },
        lua = { template = { annotation_convention = "ldoc" } },
      },
    }
  end,
}
