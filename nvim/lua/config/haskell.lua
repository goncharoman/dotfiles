local haskellft = { "haskell", "lhaskell", "cabal", "cabalproject" }

return {

  ---@type LazySpec
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
        hls = {
          settings = {
            cabalFormattingProvider = "cabalfmt",
            formattingProvider = "ormolu",
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
          "haskell",
          "yaml",
          "json",
        })
      end
    end,
  },

  ---@type LazySpec
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "haskell-debug-adapter",
        "haskell-language-server",
      })
    end,
  },

  ---@type LazySpec
  {
    "mrcjkb/haskell-snippets.nvim",
    ft = haskellft,
    dependencies = { "L3MON4D3/LuaSnip" },
    config = function()
      require("luasnip").add_snippets("haskell", require("haskell-snippets").all, { key = "haskell" })
    end,
  },

  ---@type LazySpec
  {
    "mrcjkb/haskell-tools.nvim",
    ft = haskellft,
    dependencies = {
      {
        "AstroNvim/astrolsp",
        ---@type AstroLSPOpts
        opts = {
          ---@diagnostic disable: missing-fields
          handlers = { hls = false },
        },
      },
    },
    version = "^5",
    init = function()
      local astrolsp = require "astrolsp"
      vim.g.haskell_tools = require("astrocore").extend_tbl({
        hls = {
          capabilities = astrolsp.config.capabilities,
          on_attach = astrolsp.on_attach,
        },
      }, vim.g.haskell_tools)
    end,
  },
}
