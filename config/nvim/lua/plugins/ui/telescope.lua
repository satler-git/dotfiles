return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    cmd = {
      "Telescope",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ghq.nvim",
    },
    config = function()
      require("telescope").load_extension("ghq")
    end,
  },
  {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    config = function()
      require("telescope").load_extension("smart_open")
    end,
    keys = {
      { "<Space>ff", "<Cmd>Telescope smart_open<CR>" },
    },
    dependencies = {
      "kkharji/sqlite.lua",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope.nvim",
    },
  },
}
