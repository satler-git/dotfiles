require("options")
require("commands")
require("keymaps")
require("config.lazy")

if vim.fn.has("win32")==1 then
	require("windows")
end
