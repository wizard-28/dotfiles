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
