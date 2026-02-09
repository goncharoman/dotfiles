return {

  { "mason-org/mason-lspconfig.nvim", enabled = false },

  {
    "nvim-mini/mini.surround",
    event = "VeryLazy",
    keys = function(_, keys)
      local opts = LazyVim.opts "mini.surround"
      local mappings = {
        { opts.mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete Surrounding" },
        { opts.mappings.find, desc = "Find Right Surrounding" },
        { opts.mappings.find_left, desc = "Find Left Surrounding" },
        { opts.mappings.highlight, desc = "Highlight Surrounding" },
        { opts.mappings.replace, desc = "Replace Surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      {
        "mason.nvim",
        opts = function(_, opts)
          LazyVim.misc.lstmerge(opts.ensure_installed, {
            "prettierd",
            "shfmt",
            "lua-language-server", -- lua-language-server@3.16.4 see https://github.com/folke/lazydev.nvim/issues/136
            "yaml-language-server",
            "bash-language-server",
            "json-lsp",
            "taplo",
            "tinymist",
          })
        end,
      },
      {
        "b0o/SchemaStore.nvim",
        lazy = true,
      },
    },
    opts = {
      servers = {
        tinymist = {
          settings = {
            formatterMode = "typestyle",
          },
        },
        yamlls = {
          on_new_config = function(config)
            config.settings.yaml.schemas =
              vim.tbl_deep_extend("force", config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
          end,
          settings = { yaml = { schemaStore = { enable = false, url = "" } } },
        },
        jsonls = {
          on_new_config = function(config)
            if not config.settings.json.schemas then config.settings.json.schemas = {} end
            vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = { json = { validate = { enable = true } } },
        },
      },
    },
  },

  {
    "L3MON4D3/LuaSnip",
    event = "VeryLazy",
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },
}
