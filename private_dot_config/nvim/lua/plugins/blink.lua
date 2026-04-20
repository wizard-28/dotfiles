return {
  "saghen/blink.cmp",
  opts = {
    sources = {
      transform_items = function(_, items)
        return vim.tbl_filter(function(item)
          -- remove suggestions like </header>
          return not item.label:match("^</")
        end, items)
      end,
    },
  },
}
