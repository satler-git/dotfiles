-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.cursorline = true

-- clipboard integration
vim.opt.clipboard:append({ "unnamedplus" })

-- For nvim-ufo
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- 行番号
vim.opt.number = true
vim.opt.relativenumber = true

-- タブの大きさ
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
-- vim.cmd("set retab=4")

-- エンコーディング

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.cmd('let $LANG = "ja"')

vim.opt.autoread = true
vim.opt.undofile = true
