return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true,
  },
  {
    "hrsh7th/nvim-insx",
    event = "InsertEnter",
    config = function()
      require("insx.preset.standard").setup()

      local insx = require("insx")

      insx.add(
        "'",
        insx.with({
          enabled = function(ctx)
            local before_borrowing = ctx.match([=[&\%#]=])
            local in_type_parameters = false

            local node = vim.treesitter.get_node({ pos = { ctx.row(), ctx.col() } })

            if not node then
              return true
            end

            while node do
              if
                vim.tbl_contains({
                  "trait_bounds",
                  "type_arguments",
                  "type_parameters",
                }, node:type())
              then
                in_type_parameters = true
                break
              end
              node = node:parent()
            end

            return in_type_parameters or before_borrowing
          end,
          action = function(ctx)
            ctx.send("'")
          end,
          priority = 1000,
        }, {
          insx.with.filetype({ "rust" }),
        })
      )
    end,
  },
}
