---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    local null_ls = require "null-ls"
    config.sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.diagnostics.djlint,
      null_ls.builtins.diagnostics.mypy.with {
        prefer_local = ".venv/bin",
      },
      null_ls.builtins.diagnostics.sqlfluff.with {
        extra_args = { "--dialect", "ansi" },
      },
      null_ls.builtins.formatting.sqlfluff.with {
        extra_args = { "--dialect", "ansi" },
      },
    }
    return config
  end,
}
