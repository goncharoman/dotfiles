---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local nls = require "null-ls"
    opts.sources = {
      nls.builtins.formatting.fish_indent,
      nls.builtins.diagnostics.fish,
    }
  end,
}
