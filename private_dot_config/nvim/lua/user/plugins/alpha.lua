local plugins_count = vim.fn.len(vim.fn.globpath(vim.fn.stdpath "data" .. "/site/pack/packer/start", "*", 0, 1))
  + vim.fn.len(vim.fn.globpath(vim.fn.stdpath "data" .. "/site/pack/packer/opt", "*", 0, 1))
local plugins_loaded = vim.fn.len(vim.fn.globpath(vim.fn.stdpath "data" .. "/site/pack/packer/start", "*", 0, 1))
return {
  layout = {
    { type = "padding", val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) } },
    {
      type = "text",
      val = astronvim.user_plugin_opts("header", {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }, false),
      opts = { position = "center", hl = "DashboardHeader" },
    },
    { type = "padding", val = 5 },
    {
      type = "group",
      val = {
        astronvim.alpha_button("LDR f f", "  Find File  "),
        astronvim.alpha_button("LDR s p", "  Open Project  "),
        astronvim.alpha_button("LDR f o", "  Recents  "),
        astronvim.alpha_button("LDR f w", "  Find Word  "),
        astronvim.alpha_button("LDR f n", "  New File  "),
        astronvim.alpha_button("LDR f m", "  Bookmarks  "),
        astronvim.alpha_button("LDR S l", "  Last Session  "),
      },
      opts = { spacing = 1 },
    },
    { type = "padding", val = 5 },
    {
      type = "text",
      val = {
        " AstroNvim " .. astronvim.updater.version(true),
      },
      opts = { position = "center", hl = "DashboardFooter" },
    },
    {
      type = "text",
      val = {
        "Loaded " .. plugins_loaded .. " out of " .. plugins_count .. " plugins ",
      },
      opts = { position = "center", hl = "DashboardFooter" },
    },
  },
  opts = { noautocmd = true },
}
