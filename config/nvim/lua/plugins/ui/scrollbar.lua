return {
  "petertriho/nvim-scrollbar",
  -- v2 replaced v1 on main on 2026-11-18, so no branch pin is needed.
  event = "UIEnter",
  dependencies = { "lewis6991/gitsigns.nvim" },
  opts = {
    providers = { gitsigns = true },
  },
}
