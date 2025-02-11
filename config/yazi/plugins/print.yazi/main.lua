--- @since 25.2.7

---@param printer_name string
---@return string
local function print(printer_name)
  return "lp -d" .. printer_name .. "$@"
end

-- https://github.com/yazi-rs/plugins/blob/main/chmod.yazi/main.lua
-- MIT License
-- Copyright (c) 2023 yazi-rs
local selected_or_hovered = ya.sync(function()
  local tab, paths = cx.active, {}
  for _, u in pairs(tab.selected) do
    paths[#paths + 1] = tostring(u)
  end
  if #paths == 0 and tab.current.hovered then
    paths[1] = tostring(tab.current.hovered.url)
  end
  return paths
end)

local function make_cands(keys)
  local output, err = Command("lpstat"):arg("-v"):output() -- TODO:

  if not output then
    error(tostring(err), 2)
    return
  end

  local printers = {}

  for line in output.stdout:gmatch("([^\n]+)") do
    local fields = {}
    for field in line:gmatch("%S+") do
      table.insert(fields, field)
    end
    if #fields >= 3 then
      table.insert(printers, fields[3]:sub(1, #fields[3] - 1))
    end
  end

  local cands = {}

  local keys_t = {}
  for char in keys:gmatch(".") do
    table.insert(keys_t, char)
  end
  if #keys_t < #printers then
    error("Too many printers to list")
    return
  end

  for _, printer in ipairs(printers) do
    table.insert(cands, {
      on = table.remove(keys_t, 1),
      desc = printer,
    })
  end

  return cands
end

local function entry(self, job)
  ya.manager_emit("escape", { visual = true })

  local keys = self.keys or "asdfhjkl"

  local paths = selected_or_hovered()
  if #paths == 0 then
    return ya.notify({
      title = "Print",
      content = "No file selected",
      level = "warn",
      timeout = 5,
    })
  end

  local cands, err = make_cands(keys)
  if not cands then
    return ya.notify({
      title = "Print",
      content = "Listing up printers failed: " .. tostring(err),
      level = "error",
      timeout = 5,
    })
  end
  if #cands == 0 then
    return ya.notify({
      title = "Print",
      content = "No printer found",
      level = "error",
      timeout = 5,
    })
  end

  local printer = nil
  if #cands == 1 then
    printer = cands[1]["desc"]
  else
    local cand = ya.which({
      cands = cands,
      -- silent = true, -- TODO: diff
    })

    if not cand then
      return
    end
    printer = cands[cand]["desc"]
  end

  local status, err = Command("lp"):args({ "-d", printer }):args(paths):status()
  if not status or not status.success then
    ya.notify({
      title = "Print",
      content = string.format("Running lp command failed, error: %s", status and status.code or err),
      level = "error",
      timeout = 5,
    })
  else
    ya.notify({
      title = "Print",
      content = "Running lp command success!",
      timeout = 5,
    })
  end
end

local function setup(self, opts)
  opts = opts or {}
  self.keys = opts.keys
end

return {
  entry = entry,
  setup = setup,
}
