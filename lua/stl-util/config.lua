---@private
---@class stl-util.config
local M = {}

---@class stl-util.options
M.options = {
  space = 1,
  separators = {
    right = "",
    left = "",
  },
}

---@param opts stl-util.options
function M.extend_options(opts)
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

return M
