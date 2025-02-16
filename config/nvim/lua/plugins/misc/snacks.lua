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
    init = function()
      vim.ui.input = function(...)
        require("snacks").input.enable()

        return vim.ui.select(...)
      end
    end,
    opts = {
      scratch = {},
      gitbrowse = {},
      input = {
        relative = "cursor",
      },
    },
  },
}
