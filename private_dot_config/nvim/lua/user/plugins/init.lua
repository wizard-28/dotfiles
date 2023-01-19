return {
  ["andymass/vim-matchup"] = { after = "nvim-treesitter" },
  ["danymat/neogen"] = {
    requires = "nvim-treesitter/nvim-treesitter",
    module = "neogen",
    cmd = "Neogen",
    config = function() require "user.plugins.neogen" end,
  },
  ["ethanholz/nvim-lastplace"] = {
    opt = true,
    setup = function() table.insert(astronvim.file_plugins, "nvim-lastplace") end,
    config = function() require "user.plugins.nvim-lastplace" end,
  },
  ["hrsh7th/cmp-calc"] = {
    after = "nvim-cmp",
    config = function() require "user.plugins.cmp-calc" end,
  },
  ["hrsh7th/cmp-emoji"] = {
    after = "nvim-cmp",
    config = function() require "user.plugins.cmp-emoji" end,
  },
  ["junegunn/vim-easy-align"] = {
    opt = true,
    setup = function() table.insert(astronvim.file_plugins, "vim-easy-align") end,
  },
  ["kdheepak/cmp-latex-symbols"] = {
    after = "nvim-cmp",
    config = function() require "user.plugins.cmp-latex-symbols" end,
  },
  ["kylechui/nvim-surround"] = {
    opt = true,
    setup = function() table.insert(astronvim.file_plugins, "nvim-surround") end,
  },
  ["kosayoda/nvim-lightbulb"] = {
    after = "nvim-lspconfig",
    config = function() require("nvim-lightbulb").setup { autocmd = { enabled = true } } end,
  },
  ["nvim-telescope/telescope-file-browser.nvim"] = {
    after = "telescope.nvim",
    config = function() require "user.plugins.telescope-file-browser" end,
  },
  ["nvim-telescope/telescope-project.nvim"] = {
    after = "telescope.nvim",
    config = function() require "user.plugins.telescope-project" end,
  },
  ["debugloop/telescope-undo.nvim"] = {
    after = "telescope.nvim",
    config = function() require "user.plugins.telescope-undo" end,
  },
  ["nvim-treesitter/nvim-treesitter-textobjects"] = { after = "nvim-treesitter" },
  -- ["lvimuser/lsp-inlayhints.nvim"] = {
  --   module = "lsp-inlayhints",
  --   config = function() require "user.plugins.lsp-inlayhints" end,
  -- },
  ["sindrets/diffview.nvim"] = {
    opt = true,
    setup = function() table.insert(astronvim.git_plugins, "diffview.nvim") end,
    config = function() require "user.plugins.diffview" end,
  },
  ["theHamsta/nvim-dap-virtual-text"] = {
    after = "nvim-dap",
    config = function() require "user.plugins.nvim-dap-virtual-text" end,
  },
  ["https://git.sr.ht/~whynothugo/lsp_lines.nvim"] = {
    after = "nvim-lspconfig",
    config = function() require "user.plugins.lsp_lines" end,
  },
  ["folke/trouble.nvim"] = {
    after = "nvim-lspconfig",
    config = function() require("trouble").setup {} end,
  },
  ["jghauser/mkdir.nvim"] = {},
  ["TimUntersberger/neogit"] = {
    requires = "nvim-lua/plenary.nvim",
    cmd = "Neogit",
    setup = function() table.insert(astronvim.git_plugins, "neogit") end,
    config = function() require "user.plugins.neogit" end,
  },
  ["folke/todo-comments.nvim"] = {
    opt = true,
    setup = function() table.insert(astronvim.file_plugins, "todo-comments.nvim") end,
    requires = "nvim-lua/plenary.nvim",
    config = function() require "user.plugins.todo-comments" end,
  },
  ["gpanders/editorconfig.nvim"] = {
    opt = true,
    setup = function() table.insert(astronvim.file_plugins, "editorconfig.nvim") end,
  },

  ["chrisgrieser/nvim-various-textobjs"] = {
    opt = true,
    setup = function() table.insert(astronvim.file_plugins, "nvim-various-textobjs") end,
    config = function() require "user.plugins.nvim-various-textobjs" end,
  },

  ["ggandor/leap.nvim"] = {
    config = function() require "user.plugins.leap" end,
    keys = { "s", "S" },
  },

  ["nvim-neorg/neorg"] = {
    ft = "norg",
    cmd = "Neorg",
    run = ":Neorg sync-parsers",
    config = function() require "user.plugins.neorg" end,
  },

  -- Testing
  ["nvim-neotest/neotest"] = {
    module = "neotest",
    requires = {
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
    config = function() require "user.plugins.neotest" end,
  },

  -- Markdown preview
  ["toppair/peek.nvim"] = {
    ft = "markdown",
    run = "deno task --quiet build:fast",
  },

  -- Rust programming
  ["simrat39/rust-tools.nvim"] = {
    after = { "mason-lspconfig.nvim" },
    ft = { "rust" },
    config = function() require("rust-tools").setup(require "user.plugins.rust-tools") end,
  },
  ["Saecki/crates.nvim"] = {
    event = { "BufRead Cargo.toml" },
    requires = { "plenary.nvim" },
    config = function()
      require("crates").setup(require "user.plugins.crates")
      astronvim.add_user_cmp_source "crates"
    end,
  },

  ["Exafunction/codeium.vim"] = {
    -- after = "nvim-cmp",
    config = function() require "user.plugins.codeium" end,
  },
}
