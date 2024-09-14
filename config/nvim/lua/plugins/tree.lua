return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  cmd = {
    "Neotree",
  },
  keys = {
    { "<C-n>", "<Cmd>Neotree filesystem reveal left toggle<CR>" },
  },
  opts = {
    enable_git_status = true,
    filesystem = {
      window = {
        width = 30, -- ここで幅を設定します。数値は任意で変更可能です。
      },
    },
  },
}
