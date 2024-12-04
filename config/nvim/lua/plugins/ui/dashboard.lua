return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local dashboard = require("alpha.themes.dashboard")
      local button = dashboard.button

      dashboard.section.header.val = {
        -- Ascii Art from https://ascii.co.uk/art/fox
        -- Thanks!
        [[                                                                    ,-, ]],
        [[                                                              _.-=;~ /_ ]],
        [[                                                           _-~   '     ;. ]],
        [[                                                       _.-~     '   .-~-~`-._ ]],
        [[                                                 _.--~~:.             --.____88 ]],
        [[                               ____.........--~~~. .' .  .        _..-------~~ ]],
        [[                      _..--~~~~               .' .'             ,' ]],
        [[                  _.-~                        .       .     ` ,' ]],
        [[                .'                                    :.    ./ ]],
        [[              .:     ,/          `                   ::.   ,' ]],
        [[            .:'     ,(            ;.                ::. ,-' ]],
        [[           .'     ./'.`.     . . /:::._______.... _/:.o/ ]],
        [[          /     ./'. . .)  . _.,'               `88;?88| ]],
        [[        ,'  . .,/'._,-~ /_.o8P'                  88P ?8b ]],
        [[     _,'' . .,/',-~    d888P'                    88'  88| ]],
        [[  _.'~  . .,:oP'        ?88b              _..--- 88.--'8b.--..__ ]],
        [[ :     ...' 88o __,------.88o ...__..._.=~- .    `~~   `~~      ~-._ Seal _. ]],
        [[ `.;;;:='    ~~            ~~~                ~-    -       -   - ]],
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
