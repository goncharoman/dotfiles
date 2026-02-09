vim.g.aliases = vim.tbl_extend("force", vim.g.aliases, { ["buf_ls"] = "buf" })

return {

  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    opts = {
      ensure_installed = { "proto" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      {
        "mason.nvim",
        opts = {
          ensure_installed = { "buf" },
        },
      },
    },
    opts = {
      servers = {
        buf_ls = {},
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
          ensure_installed = { "buf" },
        },
      },
    },
    opts = {
      formatters_by_ft = {
        proto = { "buf" },
      },
    },
  },
}
