-- ref: https://github.com/Wansmer/langmapper.nvim/blob/efeffd2a0add17ad04c69beb81b68329cd445eeb/README.md?plain=1#L89-L105

local M = {}

---@param str string
---@return string
local function t(str)
  -- You need to escape these characters to work correctly
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

--- ```lua
--- vim.opt.langmap = langmap([[hjkl]], [[ktns]], [[HJKL]], [[KTNS]])
--- ```
---@param origin string
---@param to string
---@param origin_shift string
---@param to_shift string
---@return string
function M.langmap(origin, to, origin_shift, to_shift)
  -- ref: https://vim-jp.org/vimdoc-ja/options.html#'langmap'
  return vim.fn.join({
      -- | `to` should be first     | `from` should be second
      t(to) .. ';' .. t(origin_shift),
      t(to_shift) .. ';' .. t(origin_shift),
  }, ',')
end 

return M
