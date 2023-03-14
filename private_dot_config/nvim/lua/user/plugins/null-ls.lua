return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    local null_ls = require "null-ls"

    -- NOTE: This configures shfmt to follow the Pacstall style guidelines.
    -- TODO: Look into configuring this automatically with https://github.com/folke/neoconf.nvim/issues/5
    opts.sources = {
      null_ls.builtins.formatting.shfmt.with {
        args = { "-kp", "-bn", "-ci", "-sr", "-s" },
      },
    }
  end,
}
