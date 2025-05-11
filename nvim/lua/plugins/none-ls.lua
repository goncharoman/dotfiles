local function selene_configured(path)
  return #vim.fs.find("selene.toml", { path = path, upward = true, type = "file" }) > 0
end

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local nls = require "null-ls"
    opts.sources = {
      nls.builtins.formatting.fish_indent,
      nls.builtins.diagnostics.fish,
      nls.builtins.formatting.prettierd,
      nls.builtins.formatting.shfmt,
      nls.builtins.diagnostics.selene.with {
        runtime_condition = function(params) return selene_configured(params.bufname) end,
      },
      nls.builtins.formatting.stylua,
    }
  end,
}
