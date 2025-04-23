---@type LazySpec
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = {
    ensure_installed = {
      -- language servers
      "yaml-language-server",
      "bash-language-server",
      "json-lsp",
      "taplo",
      "tinymist",

      -- linters
      "shellcheck",

      -- formatters
      "prettierd",
      "shfmt",

      -- any other package
      "tree-sitter-cli",
    },
    integrations = {
      ["mason-lspconfig"] = true,
      ["mason-null-ls"] = true,
      ["mason-nvim-dap"] = true,
    },
  },
}
