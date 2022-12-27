require("neotest").setup {
  adapters = {
    require "neotest-rust",
    require "neotest-python" {
      dap = { justMyCode = false },
    },
  },
}
