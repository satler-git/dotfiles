local opts = { noremap = true, silent = true }
local eopts = { noremap = true, silent = true, expr = true }
local term_opts = { silent = true }

local keymap = vim.keymap.set

-- keymap("n", "<Space>", "<Cmd><CR>", opts)

keymap("n", "U", "<C-r>", opts)
keymap("n", "<Esc><Esc>", "<Cmd>nohlsearch<CR>", opts)

-- ref: https://zenn.dev/vim_jp/articles/43d021f461f3a4
keymap("o", "i<Space>", "iW", opts)
keymap("x", "i<Space>", "iW", opts)
keymap("n", "M", "%", opts)
keymap("x", "M", "%", opts)
keymap("x", "y", "mzy`z", opts)
keymap("x", "p", "P", opts)
keymap("x", ">", ">gv", opts)
keymap("x", "<", "<gv", opts)

-- ref: https://zenn.dev/hidehic0/articles/6bde5d5398384a
keymap("n", "x", '"_x', opts)

-- ref: https://lambdalisue.hatenablog.com/entry/2015/12/25/000046
keymap("i", "<C-a>", "<C-o>^", opts)
keymap("i", "<C-e>", "<C-o>$", opts)
keymap("i", "<C-f>", "<C-o>w", opts)
keymap("i", "<C-b>", "<C-o>b", opts)

-- > Emacs 的じゃないけど、これも
-- keymap("i", "<C-h>", "<C-o>h", opts)
-- keymap("i", "<C-j>", "<C-o>j", opts)
-- keymap("i", "<C-k>", "<C-o>k", opts)
-- keymap("i", "<C-l>", "<C-o>l", opts)

keymap("n", ">", ">>", opts)
keymap("n", "<", "<<", opts)

keymap("t", "<Esc>", "<C-\\><C-n>", opts)

keymap("n", "<Space>z", "zMzv", opts)

-- https://github.com/ompugao/vim-bundle/blob/074e7b22320ad4bfba4da5516e53b498ace35a89/vimrc
-- https://github.com/monaqa/dotfiles/blob/6072f31d1d2ee395be22b46c837d9c0710ae12b8/.config/nvim/lua/rc/keymap.lua#L982
local function ifexpr(condition, true_clause, false_clause)
  if condition then
    return true_clause
  else
    return false_clause
  end
end

keymap("x", "I", function()
  return ifexpr(vim.fn.mode(0) == "V", "<C-v>0o$I", "I")
end, eopts)
keymap("x", "A", function()
  return ifexpr(vim.fn.mode(0) == "V", "<C-v>0o$A", "A")
end, eopts)
