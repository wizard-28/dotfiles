return {
  "nvim-neotest/neotest",
  module = "neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "rouge8/neotest-rust",
      module = "neotest-rust",
    },
    {
      "nvim-neotest/neotest-python",
      module = "neotest-python",
    },
  },
  config = function()
    require("neotest").setup {
      adapters = {
        require "neotest-rust",
        require "neotest-python" {
          dap = { justMyCode = false },
        },
      },
    }
  end,
}
