return {
  "2kabhishek/exercism.nvim",
  cmd = {
    "ExercismLanguages",
    "ExercismList",
    "ExercismSubmit",
    "ExercismTest",
  },
  keys = {
    "<leader>exa",
    "<leader>exl",
    "<leader>exs",
    "<leader>ext",
  },
  dependencies = {
    "2kabhishek/utils.nvim", -- required, for utility functions
    "stevearc/dressing.nvim", -- optional, highly recommended, for fuzzy select UI
    "2kabhishek/termim.nvim", -- optional, better UX for running tests
  },
  -- Add your custom configs here, keep it blank for default configs (required)
  opts = {},
  config = function()
    local exercism = require("exercism")
    exercism.setup({
      exercism_workspace = "~/code/exercism/", -- Default workspace for exercism exercises
      default_language = "c", -- Default language for exercise list
      add_default_keybindings = false, -- Whether to add default keybindings
      icons = {
        concept = "", -- Icon for concept exercises
        practice = "", -- Icon for practice exercises
      },
    })
  end,
  keys = {
    { "<leader>Xa", "<cmd>ExercismLanguages<cr>", desc = "Lists all available languages" },
    { "<leader>Xl", "<cmd>ExercismList<cr>", desc = "Lists exercises for the default language" },
    { "<leader>Xt", "<cmd>ExercismTest<cr>", desc = "Runs tests for the current exercise" },
    { "<leader>Xs", "<cmd>ExercismSubmit<cr>", desc = "Submits the current exercise" },
  },
}
