local uv = vim.uv
local addr = uv.os_getenv("NVIM_LISTEN_ADDRESS")
if addr and #vim.v.argv > 1 then
  local files = { unpack(vim.v.argv, 2) }

  local pipe = uv.new_pipe(false)
  pipe:connect(addr, function(err)
    assert(not err, err)
  end)

  vim.g.exit_flag = false
  pipe:read_start(function(err, chunk)
    assert(not err, err)
    if chunk and chunk:match("Exit") then
      vim.g.exit_flag = true
    end
  end)

  local chan = pipe

  for _, f in ipairs(files) do
    vim.rpcnotify(chan, "nvim_command", "edit" .. " " .. vim.fn.fnameescape(f)) -- barbar
    vim.rpcnotify(chan, "nvim_exec_lua", [[
        local bufnr = vim.api.nvim_get_current_buf()

        vim.api.nvim_create_autocmd("BufDelete", {
          buffer = bufnr,
          callback = function(ev)
            local chan = vim.fn.sockconnect("pipe", ]] .. addr .. [[, { rpc = true })
            vim.rpcnotify(chan, "Exit", 0)
          end,
        })
    ]])
  end

  vim.wait(nil, function()
    return vim.g.exit_flag
  end, 100)

  -- 後始末
  pipe:read_stop()
  pipe:close()

  vim.cmd("qa!")
  return
else
  vim.env.NVIM_LISTEN_ADDRESS = vim.v.servername
end

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
