vim.g.aliases = vim.tbl_extend("force", vim.g.aliases, { ["buf_ls"] = "buf" })

return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    opts = { ensure_installed = { "proto" } },
  },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "buf_ls" },
      },
    },
    opts = {
      servers = {
        buf_ls = {},
      },
    },
  },
  {
    "mason-org/mason.nvim",
    event = "VeryLazy",
    opts = {
      ensure_installed = { "buf" },
    },
  },
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    opts = {
      formatters_by_ft = {
        proto = { "buf" },
      },
    },
  },
}
