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
    opts = { ensure_installed = { "dockerfile" } },
  },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "dockerls", "docker_compose_language_service" },
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
    "mason.nvim",
    event = "VeryLazy",
    opts = { ensure_installed = { "hadolint" } },
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    opts = {
      linters_by_ft = {
        dockerfile = { "hadolint" },
      },
    },
  },
}
