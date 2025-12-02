local haskellft = { "haskell", "lhaskell", "cabal", "cabalproject" }

vim.notify("The plugin 'mrcjkb/haskell-snippets.nvim' has been disabled due to an error.\nCheck for updates", "info")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    opts = { ensure_installed = { "haskell", "yaml", "json" } },
  },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "mason.nvim",
      opts = {
        ensure_installed = { "haskell-language-server" },
      },
    },
    opts = {
      setup = {
        hls = function() return true end,
      },
    },
  },
  {
    "mrcjkb/haskell-snippets.nvim",
    enabled = false,
    ft = haskellft,
    event = "VeryLazy",
    dependencies = { "L3MON4D3/LuaSnip" },
    config = function()
      require("luasnip").add_snippets("haskell", require("haskell-snippets").all, { key = "haskell" })
    end,
  },
  {
    "mrcjkb/haskell-tools.nvim",
    ft = haskellft,
    version = "^5",
  },
}
