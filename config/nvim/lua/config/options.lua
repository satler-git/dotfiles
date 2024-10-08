-- 行番号
vim.opt.number = true
vim.opt.relativenumber = true

-- タブの大きさ
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
-- vim.cmd("set retab=4")

-- エンコーディング

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.cmd("set termencoding=utf-8")

vim.cmd('let $LANG = "ja"')

vim.opt.autoread = true
