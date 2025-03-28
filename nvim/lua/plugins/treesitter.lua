---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
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
    })
    opts.sync_install = true
  end,
}
