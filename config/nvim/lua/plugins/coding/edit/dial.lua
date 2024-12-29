return {
  "monaqa/dial.nvim",
  keys = {
    { "<C-a>", "<Plug>(dial-increment)" },
    { "<C-x>", "<Plug>(dial-decrement)" },
    { "g<C-a>", "g<Plug>(dial-increment)" },
    { "g<C-x>", "g<Plug>(dial-decrement)" },
    { "<C-a>", "<Plug>(dial-increment)", mode = "v" },
    { "<C-x>", "<Plug>(dial-decrement)", mode = "v" },
    { "g<C-a>", "g<Plug>(dial-increment)", mode = "v" },
    { "g<C-x>", "g<Plug>(dial-decrement)", mode = "v" },
  },
}
