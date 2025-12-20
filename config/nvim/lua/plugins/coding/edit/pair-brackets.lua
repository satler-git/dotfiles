local function par(par_tbl)
  return function(ctx)
    local in_par = false

    local node = vim.treesitter.get_node({ pos = { ctx.row(), ctx.col() } })

    if not node then
      return true
    end

    while node do
      if vim.tbl_contains(par_tbl, node:type()) then
        in_par = true
        break
      end
      node = node:parent()
    end
    return in_par
  end
end

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
            local in_type_parameters = par({
              "trait_bounds",
              "type_arguments",
              "type_parameters",
              -- あんまりこれは関係なくて、tree-sitterの仕様上?
              -- A: |,
              -- のように,がないとtrait_bounds判定にならない
              -- TODO:
              "where_clause",
            })(ctx)

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

      insx.add(
        "$",
        insx.with(require("insx.recipe.auto_pair")({ open = "$", close = "$" }), {
          insx.with.in_string(false),
          insx.with.in_comment(false),
          insx.with.filetype({ "typst" }),
        })
      )
    end,
  },
}
