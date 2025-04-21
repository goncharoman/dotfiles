---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local null_ls = require "null-ls"

    opts.sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.diagnostics.djlint,
      null_ls.builtins.diagnostics.mypy.with {
        prefer_local = ".venv/bin",
      },
    }
  end,
}
