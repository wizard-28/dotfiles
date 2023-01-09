vim.g.maplocalleader = ","
local wk = require "which-key"

vim.cmd "autocmd FileType * lua SetLocalKeybinds()"
function SetLocalKeybinds()
  local file_type = vim.api.nvim_buf_get_option(0, "filetype")
  local opts = { prefix = "<localleader>", buffer = 0 }
  local virtual_opts = opts
  virtual_opts.mode = "v"

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
  elseif file_type == "toml" then
    wk.register({
      ["c"] = {
        name = "Crates",
        v = { function() require("crates").show_versions_popup() end, "Show versions popup" },
        f = { function() require("crates").show_features_popup() end, "Show features popup" },
        d = { function() require("crates").show_dependencies_popup() end, "Show dependencies popup" },
        u = { function() require("crates").update_crate() end, "Update crate" },
        a = { function() require("crates").update_all_crates() end, "Update all crates" },
        U = { function() require("crates").upgrade_crate() end, "Upgrade crate" },
        A = { function() require("crates").upgrade_all_crates() end, "Upgrade all crates" },
        h = { function() require("crates").open_homepage() end, "Open homepage" },
        r = { function() require("crates").open_repository() end, "Open repository" },
        D = { function() require("crates").open_documentation() end, "Open documentation" },
        c = { function() require("crates").open_crates_io() end, "Open crates.io" },
      },
    }, opts)

    wk.register({
      ["c"] = {
        name = "Crates",
        u = { function() require("crates").update_crates() end, "Update crates" },
        U = { function() require("crates").upgrade_crates() end, "Upgrade crates" },
      },
    }, virtual_opts)
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
      x = {
        name = "Trouble",
        x = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
        w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Toggle Workspace Diagnostics" },
        d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Toggle Document Diagnostics" },
        l = { "<cmd>TroubleToggle loclist<cr>", "Toggle Location List" },
        q = { "<cmd>TroubleToggle quickfix<cr>", "Toggle Quickfix" },
      },
    },
    ["]d"] = { require("trouble").next { skip_groups = true, jump = true } },
    ["[d"] = { require("trouble").previous { skip_groups = true, jump = true } },
  },
}
