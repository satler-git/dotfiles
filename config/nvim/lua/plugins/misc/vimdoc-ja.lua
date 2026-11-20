local function restore_tags(plugin)
  if vim.fn.isdirectory(plugin.dir .. "/.git") == 0 then
    return
  end

  -- :helptags rewrites the tracked Japanese tags too, but Lazy only restores
  -- doc/tags automatically. Keep the upstream tags so updates stay clean.
  local result = vim
    .system({
      "git",
      "-C",
      plugin.dir,
      "restore",
      "--source=HEAD",
      "--worktree",
      "--",
      "doc/tags-ja",
    }, { text = true })
    :wait()
  if result.code ~= 0 then
    error("Failed to restore vimdoc-ja tags: " .. result.stderr)
  end
end

return {
  "vim-jp/vimdoc-ja",
  lazy = true,
  init = restore_tags,
  build = restore_tags,
  keys = {
    { "h", mode = "c" },
  },
}
