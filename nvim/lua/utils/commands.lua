local M = {}

---Create new augroup
---@param name string group name
---@param clear? boolean clear existing commands if the group already exists (default: true)
---@return integer # group id
M.augroup = function(name, clear) return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true }) end

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
return M
