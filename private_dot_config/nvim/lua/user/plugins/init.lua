return {
  { "catppuccin/nvim", name = "catppuccin" },
  "andymass/vim-matchup",
  {
    "junegunn/vim-easy-align",
    event = "User AstroFile",
  },
  {
    "kylechui/nvim-surround",
    lazy = true,
    event = "User AstroFile",
  },
  {
    "kosayoda/nvim-lightbulb",
    config = function() require("nvim-lightbulb").setup { autocmd = { enabled = true } } end,
  },
  "nvim-treesitter/nvim-treesitter-textobjects",
  {
    "folke/trouble.nvim",
    config = true,
  },
  "jghauser/mkdir.nvim",
  {
    "folke/todo-comments.nvim",
    event = "User AstroFile",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
  },
  {
    "gpanders/editorconfig.nvim",
    event = "User AstroFile",
  },
  -- Markdown preview
  {
    "toppair/peek.nvim",
    ft = "markdown",
    build = "deno task --quiet build:fast",
  },
  -- Rust programming
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "plenary.nvim" },
    config = function()
      return {
        null_ls = {
          enabled = true,
          name = "Crates",
        },
      }
    end,
  },
  "pest-parser/pest.vim",
  {
    "jcdickinson/codeium.nvim",
    config = true,
  },
  --"folke/neodev.nvim",
  --   config = function()
  --     require("neodev").setup {
  --       override = function(root_dir, library)
  --         library.enabled = true
  --         library.plugins = true
  --       end,
  --     }
  --   end,
  -- },
}
