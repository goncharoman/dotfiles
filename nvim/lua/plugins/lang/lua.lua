vim.g.aliases = vim.tbl_extend("force", vim.g.aliases, { ["lua_ls"] = "lua-language-server" })

return {

  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    opts = {
      ensure_installed = { "lua", "luadoc", "yaml", "toml" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      {
        "mason.nvim",
        opts = {
          ensure_installed = {
            "lua-language-server",
          },
        },
      },
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "mason.nvim",
        opts = {
          ensure_installed = { "stylua" },
        },
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    dependencies = {
      {
        "mason.nvim",
        opts = {
          ensure_installed = { "selene" },
        },
      },
    },
    opts = {
      linters_by_ft = { lua = { "selene" } },
      linters = {
        selene = {
          condition = function(ctx) return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1] end,
        },
      },
    },
  },
}
