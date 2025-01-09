return {
  {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require("notify")

      vim.notify = notify

      vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        local lvl = ({
          "ERROR",
          "WARN",
          "INFO",
          "DEBUG",
        })[result.type]

        local name = (client and client.name) or "Undefined name"

        notify({ result.message }, lvl, {
          title = "LSP | " .. name,
          timeout = 10000,
          keep = function()
            return lvl == "ERROR" or lvl == "WARN"
          end,
        })
      end
    end,
    event = "VeryLazy",
    keys = {
      { "<Space>fn", "<Cmd>Telescope notify<CR>" },
    },
  },
}
