vim.g.aliases = vim.tbl_extend("force", vim.g.aliases, {
  ["dockerls"] = "dockerfile-language-server",
  ["docker_compose_language_service"] = "docker-compose-language-service",
})

vim.filetype.add {
  pattern = {
    ["compose.*%.ya?ml"] = "yaml.docker-compose",
    ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
  },
}

return {

  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    opts = {
      ensure_installed = { "dockerfile" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      {
        "mason.nvim",
        opts = {
          ensure_installed = { "dockerfile-language-server", "docker-compose-language-service" },
        },
      },
    },
    opts = {
      servers = {
        dockerls = {},
        docker_compose_language_service = {},
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
          ensure_installed = { "hadolint" },
        },
      },
    },
    opts = {
      linters_by_ft = {
        dockerfile = { "hadolint" },
      },
    },
  },
}
