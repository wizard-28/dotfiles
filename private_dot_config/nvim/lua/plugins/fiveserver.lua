return {
  "Diogo-ss/five-server.nvim",
  cmd = { "FiveServer" },
  keys = {
    { "<localleader>f", group = "Fiveserver" },
    { "<localleader>fs", "<cmd>FiveServer start<cr>", desc = "Five server start" },
  },
  build = function()
    require("fs.utils.install")()
  end,
  opts = {
    notify = true,
    -- add other options
  },
  config = function(_, opts)
    require("fs").setup(opts)
  end,
}
