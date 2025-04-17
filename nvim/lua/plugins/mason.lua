---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- language servers
        "lua-language-server",
        "basedpyright",
        "ruff",
        "taplo",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "clangd",
        "tinymist",

        -- formatters
        "stylua",
        "prettier",
        "mypy",
        "djlint",

        -- debuggers
        "debugpy",

        -- any other package
        "tree-sitter-cli",
      },
    },
  },
}
