M = {}

---Return available linters for buffer
---@return string[] # linters names
M.linters = function()
  local lint = require "lint"
  local names = lint._resolve_linter_by_ft(vim.bo.filetype)
  names = vim.list_extend({}, names)
  if #names == 0 then vim.list_extend(names, lint.linters_by_ft["_"] or {}) end
  vim.list_extend(names, lint.linters_by_ft["*"] or {})
  local ctx = { filename = vim.api.nvim_buf_get_name(0) }
  ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
  names = vim.tbl_filter(function(name)
    local linter = lint.linters[name]
    return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
  end, names)
  return names
end

---Create new augroup
---@param name string group name
---@param clear? boolean clear existing commands if the group already exists (default: true)
---@return integer # group id
M.augroup = function(name, clear) return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = clear or true }) end

---Create new autocmd
---@param group string|integer autocmd group
---@param opts { event: string[], callback: fun(...), pattern?: string[] } otps
M.autocmd = function(group, opts)
  if type(group) == "string" then group = M.augroup(group, false) end
  return vim.api.nvim_create_autocmd(opts.event, {
    group = group,
    callback = opts.callback,
    pattern = opts.pattern,
  })
end

---Merge two lists
---@param dst any[] destination list
---@param src any[] source list
---@return any[]
M.lstmerge = function(dst, src)
  for _, item in ipairs(src) do
    if not vim.list_contains(dst, item) then table.insert(dst, item) end
  end
  return dst
end

return M
