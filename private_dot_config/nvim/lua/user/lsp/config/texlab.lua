return {
  settings = {
    ["texlab"] = {
      build = {
        onSave = true,
        executable = "latexmk",
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
      },
      chktex = {
        onOpenAndSave = true,
        onEdit = true,
      },
    },
  },
}
