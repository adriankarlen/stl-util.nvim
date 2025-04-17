local config = require "stl-utils.config"
local M = {}

M.setup = function(opts)
  config.extend_options(opts)
end

---add space of n spaces
---@param n number
---@return string
M.space = function(n)
  if n == nil or n < 1 then
    n = config.options.space
  end
  local spaces = string.rep(" ", n)
  return "%#StatusLine#" .. spaces
end

---add a split
---@return string
M.split = function()
  return "%="
end

---@param side "left" | "right"
---@param hl string
---@return string
M.separator = function(side, hl)
  if side == "right" then
    return "%#" .. hl .. "#" .. config.options.separators.right
  end
  return "%#" .. hl .. "#" .. config.options.separators.left
end

---check if the current should be truncated
---@param trunc_width number
M.should_truncate = function(trunc_width)
  local cur_width = vim.o.laststatus == 3 and vim.o.columns or vim.api.nvim_win_get_width(0)
  return cur_width < (trunc_width or -1)
end

local CTRL_S = vim.api.nvim_replace_termcodes("<C-S>", true, true, true)
local CTRL_V = vim.api.nvim_replace_termcodes("<C-V>", true, true, true)

---@class stl-util.mode
---@field long string
---@field short string
local modes = setmetatable({
  ["n"] = { long = "NORMAL", short = "N" },
  ["v"] = { long = "VISUAL", short = "V" },
  ["V"] = { long = "V-LINE", short = "V-L" },
  [CTRL_V] = { long = "V-BLOCK", short = "V-B" },
  ["s"] = { long = "SELECT", short = "S" },
  ["S"] = { long = "S-LINE", short = "S-L" },
  [CTRL_S] = { long = "S-BLOCK", short = "S-B" },
  ["i"] = { long = "INSERT", short = "I" },
  ["R"] = { long = "REPLACE", short = "R" },
  ["c"] = { long = "COMMAND", short = "C" },
  ["r"] = { long = "PROMPT", short = "P" },
  ["!"] = { long = "SHELL", short = "Sh" },
  ["t"] = { long = "TERMINAL", short = "T" },
}, {
  __index = function()
    return { long = "UNKNOWN", short = "U" }
  end,
})

---get mode info
---@return stl-util.mode
M.get_mode_info = function()
  return modes[vim.fn.mode()]
end

---apply highlight to a string
---@param s string
---@param hl string
M.apply_hl = function(s, hl)
  if hl == nil then
    return s
  end
  return "%#" .. hl .. "#" .. s
end

return M
