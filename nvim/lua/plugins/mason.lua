---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- language servers
        "lua-language-server",
        "basedpyright",
        { "ruff", version = "0.11.5" },
        "taplo",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "clangd",
        "tinymist",
        -- linters
        "mypy",

        -- formatters
        "stylua",
        "prettier",
        "djlint",

        -- debuggers
        "debugpy",

        -- any other package
        "tree-sitter-cli",
      },
      integrations = {
        ["mason-lspconfig"] = true,
        ["mason-null-ls"] = true,
        ["mason-nvim-dap"] = true,
      },
    },
  },
}
