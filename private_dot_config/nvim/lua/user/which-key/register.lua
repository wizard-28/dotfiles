return {
  n = {
    ["<leader>"] = {
      a = {
        name = "Annotate",
        ["<cr>"] = { function() require("neogen").generate() end, "Current" },
        c = { function() require("neogen").generate { type = "class" } end, "Class" },
        f = { function() require("neogen").generate { type = "func" } end, "Function" },
        t = { function() require("neogen").generate { type = "type" } end, "Type" },
        F = { function() require("neogen").generate { type = "file" } end, "File" },
      },
      g = {
        g = { "<cmd>Neogit<cr>", "Git status" },
      },
      s = {
        e = { "<cmd>Telescope file_browser<cr>", "Open File Explorer" },
        p = { "<cmd>Telescope project<cr>", "Open Projects" },
        t = { "<cmd>Telescope colorscheme<cr>", "Switch Themes" },
      },
      n = {
        name = "Neotest",
        n = { function() require("neotest").run.run() end, "Run neartest test" },
        f = { function() require("neotest").run.run(vim.fn.expand "%") end, "Test current file" },
        d = { function() require("neotest").run.run { strategy = "dap" } end, "Debug the neartest test" },
        S = { function() require("neotest").run.stop() end, "Stop the nearest test" },
        a = { function() require("neotest").run.attach() end, "Attach to the nearest test" },
        s = { function() require("neotest").summary.toggle() end, "Toggle summary panel" },
        o = { function() require("neotest").output_panel.toggle() end, "Toggle output panel" },
      },
    },
    s = {
      name = "Surf",
      s = { function() require("syntax-tree-surfer").select() end, "Surf" },
      S = { function() require("syntax-tree-surfer").select_current_node() end, "Surf Node" },
    },
    g = {
      t = {
        name = "Tree-sitter",
        v = {
          function() require("syntax-tree-surfer").targeted_jump { "variable_declaration" } end,
          "Go to Variables",
        },
        f = {
          function() require("syntax-tree-surfer").targeted_jump { "function" } end,
          "Go to Functions",
        },
        i = {
          function()
            require("syntax-tree-surfer").targeted_jump {
              "if_statement",
              "else_clause",
              "else_statement",
              "elseif_statement",
            }
          end,
          "Go to If Statements",
        },
        r = {
          function() require("syntax-tree-surfer").targeted_jump { "for_statement" } end,
          "Go to For Statements",
        },
        w = {
          function() require("syntax-tree-surfer").targeted_jump { "white_statement" } end,
          "Go to While Statements",
        },
        s = {
          function() require("syntax-tree-surfer").targeted_jump { "switch_statement" } end,
          "Go to Switch Statements",
        },
        t = {
          function()
            require("syntax-tree-surfer").targeted_jump {
              "function",
              "if_statement",
              "else_clause",
              "else_statement",
              "elseif_statement",
              "for_statement",
              "while_statement",
              "switch_statement",
            }
          end,
          "Go to Statement",
        },
      },
    },
  },
}
