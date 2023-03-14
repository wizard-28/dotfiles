return {
  "chrisgrieser/nvim-various-textobjs",
  event = "User AstroFile",
  config = function() require("various-textobjs").setup { useDefaultKeymaps = true } end,
}
