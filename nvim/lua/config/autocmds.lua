LazyVim.misc.autocmd("startup", {
  event = { "VimEnter" },
  callback = function() require("precognition").hide() end,
})

LazyVim.misc.autocmd("python", {
  event = { "BufWritePre" },
  pattern = { "*.py" },
  callback = function()
    vim.notify("Ruff: Organize imports", "debug")
    vim.lsp.buf.code_action { context = { only = { "source.fixAll.ruff" } }, apply = true }
    -- if autoformat on save is disabled, uncomment it
    -- vim.lsp.buf.format { async = vim.bo.filetype ~= "python" }
  end,
})
