if not vim.g.vscode then
  return {}
end

local vscode = require("vscode")

return {
  {
    "LazyVim/LazyVim",
    opts = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimKeymapsDefaults",
        callback = function()
          -- File actions
          vim.keymap.set("n", "<leader>ff", function()
            vscode.call("workbench.action.quickOpen")
          end)

          vim.keymap.set("n", "<leader>fr", function()
            vscode.call("workbench.action.openRecent")
          end)

          vim.keymap.set("n", "<leader>bd", function()
            vscode.call("workbench.action.closeActiveEditor")
          end)

          -- Git
          vim.keymap.set("n", "<leader>gg", function()
            vscode.call("lazygit-vscode.toggle")
          end)

          -- LSP / Code navigation
          vim.keymap.set("n", "<leader>rn", function()
            vscode.call("editor.action.rename")
          end)

          vim.keymap.set("n", "gr", function()
            vscode.call("editor.action.referenceSearch.trigger")
          end)

          vim.keymap.set("n", "K", function()
            vscode.call("editor.action.showHover")
          end)

          vim.keymap.set("n", "<leader>ca", function()
            vscode.call("editor.action.quickFix")
          end)

          -- Diagnostics
          vim.keymap.set("n", "<leader>xx", function()
            vscode.call("workbench.actions.view.problems")
          end)

          vim.keymap.set("n", "]d", function()
            vscode.call("editor.action.marker.next")
          end)

          vim.keymap.set("n", "[d", function()
            vscode.call("editor.action.marker.prev")
          end)

          -- Splits / layout
          vim.keymap.set("n", "<leader>sv", function()
            vscode.call("workbench.action.splitEditorRight")
          end)

          vim.keymap.set("n", "<leader>sh", function()
            vscode.call("workbench.action.splitEditorDown")
          end)

          -- Terminal
          vim.keymap.set("n", "<leader>tt", function()
            vscode.call("workbench.action.terminal.new")
          end)

          vim.keymap.set("n", "<leader>tc", function()
            vscode.call("workbench.action.terminal.clear")
          end)

          -- UI
          vim.keymap.set("n", "<leader>e", function()
            vscode.call("workbench.action.toggleSidebarVisibility")
          end)

          vim.keymap.set("n", "<leader>z", function()
            vscode.call("workbench.action.toggleZenMode")
          end)
        end,
      })
    end,
  },
}
