require("config.options")
require("config.autocmd")
require("config.commands")
require("config.keymaps")

-- Variables from the Nix Configs
require("extra")

-- if vim.fn.has("win32") == 1 then
--   require("config.windows")
-- end

require("config.lazy")
