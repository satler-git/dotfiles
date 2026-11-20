return {
  "petertriho/nvim-scrollbar",
  -- v2 moves to main on 2026-11-16; use its published branch in the meantime.
  branch = "refactor/v2",
  event = "UIEnter",
  dependencies = { "lewis6991/gitsigns.nvim" },
  opts = {
    providers = { gitsigns = true },
  },
}
