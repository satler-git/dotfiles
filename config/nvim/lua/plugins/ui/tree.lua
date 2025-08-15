return {
  {
    "stevearc/oil.nvim",
    opts = {
      skip_confirm_for_simple_edits = true,
    },
    keys = {
      { "<C-n>", "<Cmd>Oil<CR>" },
    },
    cmd = { "Oil" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
      {
        "<C-y>",
        "<Cmd>Yazi toggle<CR>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig | {}
    opts = {
      open_for_directories = true,
      keymaps = {
        show_help = "<f1>",
      },
      open_file_function = function(chosen_file, _, _)
        vim.cmd(string.format("tabnew %s", vim.fn.fnameescape(chosen_file)))
      end,
    },
  },
}
