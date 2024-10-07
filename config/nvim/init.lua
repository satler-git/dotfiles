require("config.options")
require("config.autocmd")
require("config.commands")
require("config.keymaps")
require("extra")
require("config.lazy")

if vim.fn.has("win32") == 1 then
  require("config.windows")
end
