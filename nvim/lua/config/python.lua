return {

  ---@type LazySpec
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      formatting = {
        format_on_save = {
          ignore_filetypes = {
            "python",
          },
        },
      },
      ---@diagnostic disable: missing-fields
      config = {
        basedpyright = {
          before_init = function(_, c)
            if not c.settings then c.settings = {} end
            if not c.settings.python then c.settings.python = {} end
            c.settings.python.pythonPath = vim.fn.exepath "python"
          end,
          settings = {
            basedpyright = {
              disableOrganizeImports = true,
              analysis = {
                typeCheckingMode = "basic",
                diagnosticMode = "workspace",
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
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = { logLevel = "error" },
        },
      },
      autocmds = {
        python = {
          cond = function() return vim.bo.ft == "python" end,
          {
            event = { "BufWritePre" },
            desc = "Ruff fixAll and format on save",
            callback = function(_)
              -- run fixall code action
              vim.lsp.buf.code_action { context = { only = { "source.fixAll.ruff" } }, apply = true } ---@diagnostic disable-line: assign-type-mismatch
              -- format code
              vim.lsp.buf.format { async = vim.bo.filetype ~= "python" }
            end,
          },
        },
      },
    },
  },

  ---@type LazySpec
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
          "python",
          "toml",
        })
      end
    end,
  },

  ---@type LazySpec
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        -- language servers
        "basedpyright",
        { "ruff", version = "0.11.5" },
        -- linters
        "mypy",
        -- formatters
        "djlint",
        -- debuggers
        "debugpy",
      })
    end,
  },

  ---@type LazySpec
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require "null-ls"
      opts.sources = require("astrocore").list_insert_unique(opts.sources, {
        null_ls.builtins.diagnostics.mypy.with {
          prefer_local = ".venv/bin",
        },
      })
    end,
  },

  ---@type LazySpec
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      filetypes = {
        extension = {
          ["j2"] = "django",
          ["django"] = "django",
        },
      },
    },
  },
}
