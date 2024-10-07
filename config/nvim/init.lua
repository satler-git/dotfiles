require("config.options")
require("config.commands")
require("config.keymaps")
require("config.extra")
require("config.lazy")

if vim.fn.has("win32") == 1 then
  require("config.windows")
end
