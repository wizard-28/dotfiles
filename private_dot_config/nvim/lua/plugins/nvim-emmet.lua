return {
  "olrtg/nvim-emmet",
  keys = {
    {
      "<leader>mw",
      function()
        require("nvim-emmet").wrap_with_abbreviation()
      end,
      mode = { "n", "v" },
      desc = "Emmet Wrap Abbreviation",
    },
  },
}
