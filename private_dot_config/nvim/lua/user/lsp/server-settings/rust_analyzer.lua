return {
  settings = {
    -- to enable rust-analyzer settings visit:
    -- https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      -- enable clippy diagnostics on save
      checkOnSave = {
        command = "clippy",
        extraArgs = { "--no-deps", "--", "--warn", "clippy::pedantic" },
      },
    },
  },
}
