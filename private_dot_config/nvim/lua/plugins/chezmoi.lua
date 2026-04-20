return {
  "xvzc/chezmoi.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    vim.keymap.set("n", "<leader>cz", function()
      require("chezmoi.pick").snacks()
    end)
    require("chezmoi").setup({
      -- your configurations
    })
  end,
}
