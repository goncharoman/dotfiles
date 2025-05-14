LazyVim.commands.autocmd("python", {
  event = { "BufWritePre" },
  pattern = { "*.py" },
  callback = function()
    vim.notify("Ruff: Organize imports", "debug")
    vim.lsp.buf.code_action { context = { only = { "source.fixAll.ruff" } }, apply = true }
    -- if autoformat on save is disabled, uncomment it
    -- vim.lsp.buf.format { async = vim.bo.filetype ~= "python" }
  end,
})

return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    opts = { ensure_installed = { "ninja", "rst", "python", "toml" } },
  },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "ruff", "basedpyright" },
      },
    },
    opts = {
      servers = {
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "info",
              configurationPreference = "filesystemFirst",
            },
          },
        },
        basedpyright = {
          before_init = function(_, client) client.settings.python = { pythonPath = vim.fn.exepath "python" } end,
          settings = {
            basedpyright = {
              disableOrganizeImports = true,
              analysis = {
                autoSearchPaths = true,
                typeCheckingMode = "recommended",
                diagnosticMode = "openFilesOnly",
                autoImportCompletions = true,
                useLibraryCodeForType = true,
                diagnosticSeverityOverrides = {
                  reportUnusedImport = "information",
                  reportUnusedFunction = "information",
                  reportUnusedVariable = "information",
                  reportGeneralTypeIssues = "none",
                  reportOptionalMemberAccess = "none",
                  reportOptionalSubscript = "none",
                  reportPrivateImportUsage = "none",
                },
              },
            },
          },
        },
      },
      setup = {
        ruff = function()
          LazyVim.lsp.on_attach(function(client, _) client.server_capabilities.hoverProvider = false end)
        end,
      },
    },
  },
  {
    "mason-org/mason.nvim",
    event = "VeryLazy",
    opts = {
      ensure_installed = { "mypy" },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    opts = {
      linters_by_ft = {
        python = { "mypy" },
      },
    },
  },
}
