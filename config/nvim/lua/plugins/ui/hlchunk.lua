return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    chunk = {
      enable = true,
    },
    line_num = {
      enable = false,
    },
    indent = {
      enable = true,
    },
    blank = {
      enable = true,
    },
  },
}
