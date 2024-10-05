return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 100,
      -- open_mapping = [[<c-t>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
    },
    keys = {
      { "<C-t>", "<Cmd>ToggleTerm<CR>" },
      { "<C-t>", "<Cmd>ToggleTerm<CR>", mode = "t" },
    },
  },
}
