return {

  {
    "echasnovski/mini.surround",
    lazy = true,
    keys = function(_, keys)
      -- Populate the keys based on the user's options
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
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      {
        "mason-org/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "lua-language-server",
            "yaml-language-server",
            "bash-language-server",
            "json-lsp",
            "taplo",
            "tinymist",
          },
        },
      },
      {
        "b0o/SchemaStore.nvim",
        lazy = true,
      },
    },
    opts = {
      servers = {
        taplo = {},
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
    "mason-org/mason.nvim",
    event = "VeryLazy",
    opts = {
      ensure_installed = { "prettierd", "shfmt" },
    },
  },

  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },
}
