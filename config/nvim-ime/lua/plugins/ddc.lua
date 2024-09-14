return {
  {
    "Shougo/ddc.vim",
    lazy = false,
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/pum.vim",
      "Shougo/ddc-ui-pum",
      "Shougo/ddc-filter-sorter_rank",
      "Shougo/ddc-filter-converter_remove_overlap",
    },
    config = function()
      local patch_global = vim.fn["ddc#custom#patch_global"]
      patch_global("ui", "pum")
      patch_global("sources", { "skkeleton" })
      patch_global("sourceOptions", {
        _ = {
          sorters = { "sorter_rank" },
          converters = { "converter_remove_overlap" },
          matchers = { "matcher_head" },
        },
        ["skkeleton"] = {
          mark = "skkeleton",
          matchers = {},
          sorters = {},
          converters = {},
          isVolatile = true,
          minAutoCompleteLength = 1,
        },
      })
      vim.fn["ddc#enable"]()
    end,
    keys = {
      { "<S-Tab>", "<Cmd>call pum#map#insert_relative(-1)<CR>", mode = "i" },
      { "<C-n>", "<Cmd>call pum#map#select_relative(+1)<CR>", mode = "i" },
      { "<C-p>", "<Cmd>call pum#map#select_relative(-1)<CR>", mode = "i" },
      { "<C-y>", "<Cmd>call pum#map#confirm()<CR>", mode = "i" },
      { "<C-e>", " <Cmd>call pum#map#cancel()<CR>", mode = "i" },
    },
  },
}
