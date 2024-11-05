return {
  {
    "3rd/image.nvim",
    ft = {
      "markdown",
      "neorg",
      "typst",
    },
    build = false,
    opts = {
      backend = "ueberzug",
      processor = "magick_cli",
    },
  },
}
