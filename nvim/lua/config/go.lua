return {

  ---@type LazySpec
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
        opts = {
          ---@diagnostic disable-next-line: missing-fields
          config = {
            gopls = {
              settings = {
                gopls = {
                  analyses = {
                    ST1003 = true,
                    fieldalignment = false,
                    fillreturns = true,
                    nilness = true,
                    nonewvars = true,
                    shadow = true,
                    undeclaredname = true,
                    unreachable = true,
                    unusedparams = true,
                    unusedwrite = true,
                    useany = true,
                  },
                  codelenses = {
                    generate = true, -- show the `go generate` lens.
                    regenerate_cgo = true,
                    test = true,
                    tidy = true,
                    upgrade_dependency = true,
                    vendor = true,
                  },
                  hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                  },
                  buildFlags = { "-tags", "integration" },
                  completeUnimported = true,
                  diagnosticsDelay = "500ms",
                  gofumpt = true,
                  matcher = "Fuzzy",
                  semanticTokens = true,
                  staticcheck = true,
                  symbolMatcher = "fuzzy",
                  usePlaceholders = true,
                },
              },
            },
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
          "go",
          "gomod",
          "gosum",
          "gowork",
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
        "gopls",
        -- formatters
        "gomodifytags",
        "gotests",
        "goimports",
        -- debugger
        "delve",
        -- other
        "iferr",
        "impl",
      })
    end,
  },

  ---@type LazySpec
  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = function(_, opts)
  --     local null_ls = require "null-ls"
  --     opts.sources = require("astrocore").list_insert_unique(opts.sources, {
  --       null_ls.builtins.code_actions.gomodifytags,
  --       null_ls.builtins.formatting.goimports,
  --     })
  --   end,
  -- },

  ---@type LazySpec
  {
    "echasnovski/mini.icons",
    optional = true,
    opts = {
      file = {
        [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
      },
      filetype = {
        gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
      },
    },
  },

  ---@type LazySpec
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    build = function()
      if not require("lazy.core.config").spec.plugins["mason.nvim"] then
        vim.print "Installing go dependencies..."
        vim.cmd.GoInstallDeps()
      end
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "williamboman/mason.nvim", optional = true }, -- by default use Mason for go dependencies
    },
    opts = {},
  },
}
