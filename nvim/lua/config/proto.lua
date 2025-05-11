return {

  ---@type LazySpec
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
          "proto",
        })
      end
    end,
  },

  ---@type LazySpec
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "buf",
      })
    end,
    specs = {

      ---@type LazySpec
      {
        "AstroNvim/astrolsp",
        ---@type AstroLSPOpts
        opts = {
          handlers = {
            buf_ls = false,
          },
          servers = { "buf:lsp" },
          ---@diagnostic disable: missing-fields
          config = {
            ["buf:lsp"] = {
              cmd = { "buf", "beta", "lsp", "--timeout=0", "--log-format=text" },
              filetypes = { "proto" },
              root_dir = require("lspconfig.util").root_pattern { "buf.yaml", "buf.yml", ".git" },
            },
          },
        },
      },
    },
  },

  ---@type LazySpec
  {
    "nvimtools/none-ls.nvim",
    opts = function()
      local nls = require "null-ls"
      nls.register {
        name = "buf:format",
        filetypes = { "proto" },
        sources = {
          nls.builtins.formatting.buf.with {
            condition = function(utils) return utils.root_has_file { "buf.yaml", "buf.yml" } end,
          },
        },
      }
    end,
  },
}
