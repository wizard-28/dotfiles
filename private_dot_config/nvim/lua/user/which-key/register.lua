vim.g.maplocalleader = ","
local wk = require "which-key"

vim.cmd "autocmd FileType * lua SetLocalKeybinds()"
function SetLocalKeybinds()
  local file_type = vim.api.nvim_buf_get_option(0, "filetype")
  local opts = { prefix = "<localleader>", buffer = 0 }

  if file_type == "rust" then
    wk.register({
      ["r"] = {
        name = "Rust Tools",
        r = { function() require("rust-tools").runnables.runnables() end, "Runnables" },
        e = { function() require("rust-tools").expand_macro.expand_macro() end, "Expand Macro" },
        u = { function() require("rust-tools").move_item.move_item(true) end, "Move item up" },
        d = { function() require("rust-tools").move_item.move_item(false) end, "Move item down" },
        c = { function() require("rust-tools").open_cargo_toml.open_cargo_toml() end, "Open Cargo.toml" },
        p = { function() require("rust-tools").parent_module.parent_module() end, "Goto Parent Module" },
        j = { function() require("rust-tools").join_lines.join_lines() end, "Join Lines" },
        s = { function() require("rust-tools").ssr.ssr() end, "Structural Search Replace" },
        C = { function() require("rust-tools").crate_graph.view_crate_graph() end, "View Crate Graph" },
      },
    }, opts)
  end
end

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
        g = {
          function()
            require("telescope.builtin").find_files {
              prompt_title = "Neovim Config",
              cwd = "~/.config/nvim/lua/user/",
            }
          end,
          "Find neovim config",
        },
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
