vim.opt.laststatus=0
vim.opt.fillchars = {
  stl = '─',
  stlnc = '─',
}
vim.opt.statusline = '─'

autocmd({'WinEnter', 'BufEnter', 'ColorScheme'}, {
  group = MyAuGroup,
  pattern = '*',
  callback = function()
    local bg = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg#")
    local fg = vim.fn.synIDattr(vim.fn.hlID("VertSplit"), "fg#")

    if bg ~= "" then
      vim.cmd("hi StatusLine ctermbg=NONE guibg=" .. bg .. " ctermfg=NONE guifg=" .. fg)
      vim.cmd("hi StatuslineNC ctermbg=NONE guibg=" .. bg .. " ctermfg=NONE guifg=" .. fg)
    else
      vim.cmd("hi StatusLine ctermbg=NONE guibg=NONE ctermfg=NONE guifg=" .. fg)
      vim.cmd("hi StatuslineNC ctermbg=NONE guibg=NONE ctermfg=NONE guifg=" .. fg)
    end
  end,
  once = true,
})

