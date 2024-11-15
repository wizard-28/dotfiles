return {
  "Vigemus/iron.nvim",
  config = function()
    local iron = require("iron.core")
    local view = require("iron.view")

    iron.setup({
      config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
          sh = {
            -- Can be a table or a function that
            -- returns a table (see below)
            command = { "zsh" },
          },
          python = {
            command = { "ipython", "--no-autoindent" },
            format = require("iron.fts.common").bracketed_paste_python,
          },
        },
        -- How the repl window will be displayed
        -- See below for more information
        repl_open_cmd = view.split.vertical.botright(50),
      },
      -- Iron doesn't set keymaps by default anymore.
      -- You can set them here or manually add keymaps to the functions in iron.core
      keymaps = {
        send_motion = "<localleader>sc",
        visual_send = "<localleader>sc",
        send_file = "<localleader>sf",
        send_line = "<localleader>sl",
        send_paragraph = "<localleader>sp",
        send_until_cursor = "<localleader>su",
        send_mark = "<localleader>sm",
        mark_motion = "<localleader>mc",
        mark_visual = "<localleader>mc",
        remove_mark = "<localleader>md",
        cr = "<localleader>s<cr>",
        interrupt = "<localleader>s<localleader>",
        exit = "<localleader>sq",
        clear = "<localleader>cl",
      },
      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {
        italic = true,
      },
      ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
    })

    -- iron also has a list of commands, see :h iron-commands for all available commands
    vim.keymap.set("n", "<localleader>rs", "<cmd>IronRepl<cr>")
    vim.keymap.set("n", "<localleader>rr", "<cmd>IronRestart<cr>")
    vim.keymap.set("n", "<localleader>rf", "<cmd>IronFocus<cr>")
    vim.keymap.set("n", "<localleader>rh", "<cmd>IronHide<cr>")
  end,
}
