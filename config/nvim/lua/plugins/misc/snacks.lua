return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<Space>.",
        function()
          Snacks.scratch()
        end,
      },
      {
        "<Space>Ss",
        function()
          Snacks.scratch.select()
        end,
      },
      {
        "<Space>Sg",
        function()
          Snacks.gitbrowse()
        end,
      },
    },
    ---@type snacks.Config
    opts = {
      scratch = {},
      gitbrowse = {},
    },
  },
}
