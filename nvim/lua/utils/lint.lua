return {
  linters = function()
    local lint = require("lint")
    local names = lint._resolve_linter_by_ft(vim.bo.filetype)
    names = vim.list_extend({}, names)
    if #names == 0 then
      vim.list_extend(names, lint.linters_by_ft["_"] or {})
    end
    vim.list_extend(names, lint.linters_by_ft["*"] or {})
    local ctx = { filename = vim.api.nvim_buf_get_name(0) }
    ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
    names = vim.tbl_filter(function(name)
      local linter = lint.linters[name]
      return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
    end, names)
    return names
  end,
}
