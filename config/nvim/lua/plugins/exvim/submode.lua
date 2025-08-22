return {
  {
    "nvimtools/hydra.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
      local Hydra = require("hydra")

      local silent = { silent = true }

      Hydra({
        name = "Window",

        mode = "n",
        body = "<C-w>",

        config = {},
        heads = {
          { "h", "<C-w>h", silent },
          { "j", "<C-w>j", silent },
          { "k", "<C-w>k", silent },
          { "l", "<C-w>l", silent },

          { "+", "<C-w>+", silent },
          { "-", "<C-w>-", silent },
          { "<", "<C-w><", silent },
          { ">", "<C-w>>", silent },
          { "=", "<C-w>=", silent },

          { "H", "<C-w>H", silent },
          { "J", "<C-w>J", silent },
          { "K", "<C-w>K", silent },
          { "L", "<C-w>L", silent },
          { "R", "<C-w>R", silent },
          { "r", "<C-w>r", silent },

          { "w", "<C-w><C-w>", silent },
          { "<C-w>", "<Plug>(snipewin)", silent },

          { "c", "<C-w>c", silent },
          { "o", "<C-w>o", silent },

          { "n", "<C-w>n", silent },
          { "v", "<C-w>v", silent },
          { "s", "<C-w>s", silent },

          { "p", "<C-w>p", silent },

          { "f", "<Cmd>Telescope smart_open<CR>", silent },

          { "<Esc>", nil, { exit = true } },
        },
      })
    end,
  },
}
