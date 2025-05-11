return {

  ---@type LazySpec
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      filetypes = {
        pattern = {
          ["compose.*%.ya?ml"] = "yaml.docker-compose",
          ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
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
          "dockerfile",
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
        "docker-compose-language-service",
        "dockerfile-language-server",
        --- linter
        "hadolint",
      })
    end,
  },

  ---@type LazySpec
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require "null-ls"
      opts.sources = require("astrocore").list_insert_unique(opts.sources, {
        nls.builtins.diagnostics.hadolint,
      })
    end,
  },
}
