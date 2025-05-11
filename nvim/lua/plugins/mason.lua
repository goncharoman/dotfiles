---@type LazySpec
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    ---@type LazySpec
    {
      "jay-babu/mason-null-ls.nvim",
      opts = function(_, opts)
        opts.handlers = { function() end } -- disable automatic setup of all null-ls sources
      end,
    },
  },
  opts = {
    ensure_installed = {
      -- language servers
      "lua-language-server",
      "yaml-language-server",
      "bash-language-server",
      "json-lsp",
      "taplo",
      "tinymist",

      -- linter
      "selene",

      -- formatters
      "prettierd",
      "shfmt",
      "stylua",
    },
    integrations = {
      ["mason-lspconfig"] = true,
      ["mason-null-ls"] = true,
      ["mason-nvim-dap"] = true,
    },
  },
  specs = {
    ---@type LazySpec
    {
      "AstroNvim/astrolsp",
      ---@type AstroLSPOpts
      opts = {
        ---@diagnostic disable: missing-fields
        config = {
          tinymist = {
            settings = {
              formatterMode = "typestyle",
            },
          },
        },
      },
    },
  },
}
