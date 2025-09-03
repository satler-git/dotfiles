return {
  {
    "thinca/vim-qfreplace",
    cmd = { "Qfreplace" },
  },
  {
    "itchyny/vim-qfedit",
    ft = { "qf" },
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = true,
  },
  {
    "satler-git/qfsync.nvim",
    ft = { "qf" },
    cmd = { "QfSyncAll" },
    keys = {
      {
        "<Space>qq",
        function()
          require("qfsync").sync_all()
        end,
        mode = { "n" },
      },
    },
  },
}
