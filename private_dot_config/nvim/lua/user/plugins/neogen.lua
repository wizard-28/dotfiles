require("neogen").setup {
  snippet_engine = "luasnip",
  languages = {
    rust = { template = { annotation_convention = "rustdoc" } },
    lua = { template = { annotation_convention = "ldoc" } },
  },
}
