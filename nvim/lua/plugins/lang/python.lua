return {

  {
    "linux-cultist/venv-selector.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>tp", "<cmd>VenvSelect<cr>" },
    },
    dependencies = {
      {
        "folke/which-key.nvim",
        opts = function(_, opts)
          table.insert(
            opts.spec,
            { "<leader>tp", desc = "Python venv selector", icon = { icon = " ", color = "blue" } }
          )
        end,
      },
    },
    opts = {
      search = {
        ["global"] = {
          command = "fd '/bin/python$' $(pyenv prefix) --no-ignore-vcs --full-path --color never -E pkgs/ -E envs/ -L",
        },
      },
      options = {},
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    opts = {
      ensure_installed = { "ninja", "rst", "python", "toml" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      {
        "mason.nvim",
        opts = function(_, opts)
          LazyVim.misc.lstmerge(opts.ensure_installed, {
            "ruff",
            "basedpyright",
          })
        end,
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
          Snacks.util.lsp.on({ name = "ruff" }, function(_, client)
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end)
        end,
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    dependencies = {
      {
        "mason.nvim",
        opts = function(_, opts)
          LazyVim.misc.lstmerge(opts.ensure_installed, {
            "mypy",
          })
        end,
      },
    },
    opts = {
      linters_by_ft = {
        python = { "mypy" },
      },
    },
  },
}
