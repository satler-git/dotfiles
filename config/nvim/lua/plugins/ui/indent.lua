return {
  {
    "shellRaining/hlchunk.nvim",
    -- enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      chunk = {
        enable = true,
      },
      line_num = {
        enable = false,
      },
      indent = {
        enable = false,
      },
      blank = {
        enable = false,
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = {
        char = "┃",
      },
      whitespace = {
        remove_blankline_trail = false,
      },
      scope = { enabled = false },
    },
  },
}
