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
      f = {
        u = { "<cmd>Telescope undo<cr>", "Open undo history" },
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
  },
}
