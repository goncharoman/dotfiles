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
        ruff = {
          init_options = {
            settings = {
              logLevel = "info",
              configurationPreference = "filesystemFirst",
            },
          },
        },
      },
      autocmds = {
        python_lsp = {
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
          {
            event = { "LspAttach" },
            desc = "Disable hover capability from Ruff",
            callback = function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client == nil then return end
              if client.name == "ruff" then client.server_capabilities.hoverProvider = false end
            end,
          },
        },
      },
    },
  },

  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      autocmds = {
        pyvenv = {
          {
            event = { "VimEnter" },
            desc = "Setup python venv on start neovim",
            callback = function()
              if vim.fn.isdirectory ".venv" == 1 and vim.fn.filereadable ".venv/pyvenv.cfg" == 1 then
                vim.notify "Local python virtual environment found (.venv). It will be set"
                vim.env.VIRTUAL_ENV = vim.fn.getcwd() .. "/.venv"
                vim.env.PATH = (vim.env.VIRTUAL_ENV .. "/bin") .. ":" .. vim.env.PATH
              end
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
      local nls = require "null-ls"
      opts.sources = require("astrocore").list_insert_unique(opts.sources, {
        nls.builtins.diagnostics.mypy.with {
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
