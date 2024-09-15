return {
  {
    "Shougo/ddc.vim",
    lazy = false,
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/ddc-filter-converter_remove_overlap",
      "Shougo/ddc-source-around",
      "Shougo/ddc-ui-pum",
      "Shougo/pum.vim",
      "tani/ddc-fuzzy",
    },
    config = function()
      local patch_global = vim.fn["ddc#custom#patch_global"]
      patch_global("ui", "pum")
      patch_global("sources", { "skkeleton", "around" })
      patch_global("sourceOptions", {
        _ = {
          sorters = { "sorter_fuzzy" },
          converters = { "converter_remove_overlap", "converter_fuzzy" },
          matchers = { "matcher_fuzzy" },
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
