return {
  -- Unison
  "unisonweb/unison",
  branch = "trunk",
  config = function(plugin)
    vim.opt.rtp:append(plugin.dir .. "/editor-support/vim")
    require("lazy.core.loader").packadd(plugin.dir .. "/editor-support/vim")
  end,
  init = function(plugin)
    require("lazy.core.loader").ftdetect(plugin.dir .. "/editor-support/vim")
  end,
}
