---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "python",
      "toml",
      "yaml",
      "sql",
      "json",
      "c",
      "gitignore",
      "helm",
      "dockerfile",
      "go",
      "make",
      "ssh_config",
      "kdl",
    },
    sync_install = true,
  },
}
