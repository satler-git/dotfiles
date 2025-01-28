-- See https://neovim.io/doc/user/lsp.html#_lua-module:-vim.lsp.inlay_hint for more info
vim.api.nvim_create_user_command("ToggleInlayHint", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, {})

vim.api.nvim_create_user_command("CopyRish", function()
  vim.system({ "pandoc", "--self-contained", "-t", "html", "-f", "markdown_github+raw_html" }, {
    stdin = vim.api.nvim_buf_get_text(0, 0, 0, -1, -1, {}),
  }, function(pandoc_result)
    if pandoc_result.code ~= 0 then
      vim.notify("Pandoc Error", vim.log.levels.ERROR)
      return
    end

    vim.system({ "wl-copy", "--type", "text/html" }, {
      stdin = pandoc_result.stdout,
    }, function(copy_result)
      if copy_result.code == 0 then
        vim.notify("Copied!", vim.log.levels.INFO)
      end
    end)
  end)
end, {})
