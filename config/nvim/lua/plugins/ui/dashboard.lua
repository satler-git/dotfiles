return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local dashboard = require("alpha.themes.dashboard")
      local button = dashboard.button

      dashboard.section.header.val = {
        [[                               __                ]],
        [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      }

      dashboard.section.buttons.val = {
        button("a", "  New file", "<Cmd>ene <CR>"),
        button("s", "󰈞  Find file", "<Cmd>Telescope smart_open<CR>"),
        button("d", "󰈬  Find word", "<Cmd>Telescope live_grep<CR>"),
        button("f", "  Open Project", "<Cmd>Telescope ghq<CR>"),
        button("L", "󰒲  Manage plugins", "<Cmd>Lazy<CR>"),
        button("q", "  Exit", "<Cmd>qa!<CR>"),
      }

      require("alpha").setup(dashboard.config)
    end,
  },
}
