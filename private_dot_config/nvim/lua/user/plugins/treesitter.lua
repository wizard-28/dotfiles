return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-context", config = true },
  },
  opts = {
    -- Automatically install missing parsers when entering buffer
    auto_install = true,
    matchup = { enable = true },
    rainbow = { enable = true },
  },
}
