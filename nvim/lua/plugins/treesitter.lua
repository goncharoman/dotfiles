---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "luadoc",

      "vim",
      "vimdoc",

      "bash",
      "fish",

      "csv",

      "markdown",
      "markdown_inline",

      "yaml",
      "toml",
      "json",
      "jsonc",

      "sql",

      "gitignore",
      "gitcommit",
      "git_config",
      "git_rebase",
      "diff",

      "ini",
      "ssh_config",
      "kdl",

      "make",
    },
    sync_install = true,
  },
}
