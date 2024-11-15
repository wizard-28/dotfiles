return {
  "monaqa/dial.nvim",
  opts = function(_, opts)
    local augend = require("dial.augend")
    local english_numbers = augend.constant.new({
      elements = {
        "one",
        "two",
        "three",
        "four",
        "five",
        "six",
        "seven",
        "eight",
        "nine",
        "ten",
      },
      word = false,
      cyclic = true,
    })

    local colors = augend.constant.new({
      elements = {
        "red",
        "green",
        "blue",
      },
      word = false,
      cyclic = true,
    })

    table.insert(opts.groups.default, colors)
    table.insert(opts.groups.default, english_numbers)
  end,
}
