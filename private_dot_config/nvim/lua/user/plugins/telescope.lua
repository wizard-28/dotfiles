return {
  "nvim-telescope/telescope.nvim",
  dependencies = {

    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-project.nvim",
    "debugloop/telescope-undo.nvim",
  },
  config = function(plugin, opts)
    require "plugins.configs.telescope"(plugin, opts)

    local telescope = require "telescope"
    telescope.load_extension "file_browser"
    telescope.load_extension "project"
    telescope.load_extension "undo"
  end,
}
