return {
  "mrcjkb/haskell-tools.nvim",
  ft = { "haskell" },
  branch = "1.x.x",
  opts = function()
    return {
      tools = {
        hoogle = {
          mode = "browser",
        },
        hover = {
          auto_focus = true,
        },
        definition = {
          hoogle_signature_fallback = true,
        },
        repl = {
          handler = "toggleterm",
        },
      },
      hls = {
        on_attach = astronvim.lsp.on_attach,
      },
    }
  end,
}
