return {

  {
    "LazyVim/LazyVim",
    event = "VeryLazy",
    priority = 100,
    dependencies = {
      {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 100,
        opts = function(_, opts)
          opts.variant = "moon"
          opts.enable = {
            terminal = true,
            legacy_highlights = true,
          }
          opts.styles = {
            bold = false,
            italic = false,
            transparency = false,
          }
          opts.palette = {
            moon = {
              pine = "#59A6C5",
              lfoam = "#D3EAEE",
            },
          }
          opts.highlight_groups = {
            ["WinBar"] = { bg = "base", fg = "subtle" },
            ["WinBarNC"] = { bg = "base", fg = "muted" },
            ["@constant.builtin.python"] = { fg = "love" },
            ["@variable.builtin"] = { italic = true },
            ["@variable.parameter"] = { italic = true },
            ["@variable.member"] = { fg = "lfoam", italic = true },
            ["@constructor.python"] = { fg = "foam", italic = false },
            ["@keyword"] = { italic = true },
            ["@keyword.operator"] = { fg = "pine", italic = true },
            ["@keyword.function"] = { fg = "pine", italic = true },
            ["@keyword.import"] = { fg = "pine", italic = true },
            ["@function.method.call.python"] = { fg = "rose" },
            ["@keyword.repeat.python"] = { fg = "pine", italic = true },
            ["@keyword.exception.python"] = { fg = "pine", italic = true },
            ["@keyword.conditional.python"] = { fg = "pine", italic = true },
            ["@keyword.return"] = { italic = true },
            ["@constant.python"] = { fg = "love" },
            ["@lsp.type.decorator.python"] = { italic = true },
            ["@lsp.type.class.python"] = { fg = "foam" },
            ["@module.python"] = { fg = "lfoam" },
            ["@attribute.python"] = { fg = "iris", italic = true },
          }
        end,
      },
    },
    opts = {
      colorscheme = "rose-pine",
    },
    specs = {
      { "folke/tokyonight.nvim", enabled = false },
      { "catppuccin/nvim", enabled = false },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          prefix = "●",
        },
        float = {
          focusable = true,
          style = "modern",
          border = "rounded",
          source = false,
          prefix = function(diagnostic, _, _) return string.format("%s: ", diagnostic.source), "Italic" end,
          suffix = function(diagnostic) return string.format("(%s)", diagnostic.code), "NonText" end,
          header = { "Diagnostics:", "NvimFloat" },
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
      }
      LazyVim.color.hlset(
        "DiagnosticVirtualTextError",
        LazyVim.color.extand(
          "DiagnosticVirtualTextError",
          vim.tbl_extend(
            "force",
            LazyVim.color.trans("DiagnosticVirtualTextError", 0.75),
            { italic = true, bg = "none" }
          )
        )
      )
      LazyVim.color.hlset(
        "DiagnosticVirtualTextWarn",
        LazyVim.color.extand(
          "DiagnosticVirtualTextWarn",
          vim.tbl_extend(
            "force",
            LazyVim.color.trans("DiagnosticVirtualTextWarn", 0.75),
            { italic = true, bg = "none" }
          )
        )
      )
      LazyVim.color.hlset(
        "DiagnosticVirtualTextInfo",
        LazyVim.color.extand(
          "DiagnosticVirtualTextInfo",
          vim.tbl_extend(
            "force",
            LazyVim.color.trans("DiagnosticVirtualTextInfo", 0.75),
            { italic = true, bg = "none" }
          )
        )
      )
      LazyVim.color.hlset(
        "DiagnosticVirtualTextHint",
        LazyVim.color.extand(
          "DiagnosticVirtualTextHint",
          vim.tbl_extend(
            "force",
            LazyVim.color.trans("DiagnosticVirtualTextHint", 0.75),
            { italic = true, bg = "none" }
          )
        )
      )
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = function(_, opts)
      opts.spec = {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>c", group = "code" },
          { "<leader>d", group = "debug" },
          { "<leader>dp", group = "profiler" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>q", group = "quit/session" },
          { "<leader>s", group = "search" },
          { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
          { "<leader>l", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
          {
            "<leader>b",
            group = "buffer",
            expand = function() return require("which-key.extras").expand.buf() end,
          },
        },
      }
    end,
    specs = {
      {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        keys = {
          { "<leader>xt", false },
          { "<leader>xT", false },
        },
      },
      {
        "folke/trouble.nvim",
        event = "VeryLazy",
        keys = function()
          return {
            {
              "[q",
              function()
                if require("trouble").is_open() then
                  require("trouble").prev { skip_groups = true, jump = true }
                else
                  local ok, err = pcall(vim.cmd.cprev)
                  if not ok then vim.notify(err, vim.log.levels.ERROR) end
                end
              end,
              desc = "Previous Trouble/Quickfix Item",
            },
            {
              "]q",
              function()
                if require("trouble").is_open() then
                  require("trouble").next { skip_groups = true, jump = true }
                else
                  local ok, err = pcall(vim.cmd.cnext)
                  if not ok then vim.notify(err, vim.log.levels.ERROR) end
                end
              end,
              desc = "Next Trouble/Quickfix Item",
            },
          }
        end,
      },
      {
        "mason-org/mason.nvim",
        event = "VeryLazy",
        keys = function() return {} end,
      },
      {
        "folke/snacks.nvim",
        keys = {
          {
            "<leader>o",
            function()
              local picker = Snacks.picker.get({ source = "explorer" })[1]
              if picker ~= nil then
                if picker:is_focused() then
                  vim.cmd.wincmd "p"
                else
                  picker:focus()
                end
              end
            end,
            desc = "Explorer focus",
          },
        },
      },
    },
  },

  {
    "folke/snacks.nvim",
    event = "VeryLazy",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            [[   ███          █████      █████                     ]],
            [[  ░░░███       ░░███      ░░███                      ]],
            [[    ░░░███      ░███████  ███████   █████ ███ █████  ]],
            [[      ░░░███    ░███░░███░░░███░   ░░███ ░███░░███   ]],
            [[       ███░     ░███ ░███  ░███     ░███ ░███ ░███   ]],
            [[     ███░       ░███ ░███  ░███ ███ ░░███████████    ]],
            [[   ███░         ████████   ░░█████   ░░████░████     ]],
            [[  ░░░          ░░░░░░░░     ░░░░░     ░░░░ ░░░░      ]],
          }, "\n"),
        },
      },
      image = { enabled = false },
      notifier = { level = vim.log.levels.DEBUG },
      picker = {
        sources = {
          explorer = {
            title = "Explorer",
            diagnostics = false,
            ignored = {
              "**/.venv",
            },
            exclude = {
              "**/__pycache__",
              "**/.*_cache",
            },
            include = {
              ".gitignore",
              ".env.*",
              ".env",
              ".ci",
              ".github",
            },
          },
        },
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.options.themable = true
      -- opts.options.always_show_bufferline = true
      opts.options.separator_style = "slant"
      opts.options.enforce_regular_tabs = true
      opts.options.diagnostics = false
      opts.options.offsets = {
        {
          filetype = "snacks_layout_box",
          -- text = "Explorer",
          highlight = "SnacksPickerInputBorder",
          text_align = "center",
        },
      }
      opts.highlights = {
        fill = {
          bg = LazyVim.color.hlcolor("SnacksNormalNC", "bg"),
        },
        separator = {
          fg = LazyVim.color.hlcolor("SnacksNormalNC", "bg"),
        },
        separator_visible = {
          fg = LazyVim.color.hlcolor("SnacksNormalNC", "bg"),
        },
        separator_selected = {
          fg = LazyVim.color.hlcolor("SnacksNormalNC", "bg"),
        },
      }
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    opts = function(_, opts)
      local icons = LazyVim.config.icons

      local components = {
        statusline = {
          mode = {
            function() return "btw" end,
            padding = { right = 2, left = 2 },
          },
          gitbranch = {
            "branch",
            icon = "",
          },
          gitdiff = {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
          filepath = LazyVim.lualine.pretty_path(),
          lspinfo = {
            "lsp_status",
            icon = " :",
            symbols = {
              spinner = {},
              done = "",
              separator = ",",
            },
            color = function() return { fg = LazyVim.color.hlcolor("lualine_b_normal", "fg") } end,
          },
          diagnostics = {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          filetype = "filetype",
          location = "location",
          langtools = {
            function()
              local clients = {}
              for _, client in pairs(LazyVim.lsp.get_clients { bufnr = 0 }) do
                if client.name ~= "copilot" and client.name ~= "null-ls" then
                  table.insert(clients, vim.g.aliases[client.name] or client.name)
                end
              end

              local formatters = {}
              for _, fmtr in pairs(LazyVim.format.resolve(0)) do
                if fmtr.active == true then
                  for _, name in ipairs(fmtr.resolved) do
                    table.insert(formatters, vim.g.aliases[name] or name)
                  end
                end
              end

              local linters = {}
              for _, linter in pairs(LazyVim.lint.linters()) do
                table.insert(linters, vim.g.aliases[linter] or linter)
              end

              local msg = ""

              if #formatters ~= 0 then msg = string.format("fmt: %s", table.concat(formatters, ", ")) .. msg end
              if #linters ~= 0 then
                msg = string.format("lnt: %s%s", table.concat(linters, ", "), msg ~= "" and " " or "") .. msg
              end
              if #clients ~= 0 then
                msg = string.format(
                  " : %s%s",
                  table.concat(clients, ", "),
                  msg ~= "" and string.format(" [%s]", msg) or ""
                )
              end

              return msg
            end,
            color = function() return { fg = LazyVim.color.hlcolor("lualine_b_normal", "fg") } end,
            draw_empty = false,
          },
        },
        winbar = {
          navic = {
            "navic",
            color_correction = "dynamic",
            color = "FoldColumn",
            draw_empty = true,
          },
        },
      }

      opts.sections = {
        lualine_a = { components.statusline.mode },
        lualine_b = { components.statusline.gitbranch },
        lualine_c = { components.statusline.filepath, components.statusline.gitdiff },
        lualine_x = { components.statusline.diagnostics, components.statusline.langtools },
        lualine_y = { components.statusline.filetype },
        lualine_z = { components.statusline.location },
      }

      opts.winbar = {
        lualine_c = { components.winbar.navic },
      }
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = function(_, opts) opts.presets.bottom_search = false end,
  },

  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      LazyVim.lsp.on_attach(function(client, buffer)
        if client.supports_method "textDocument/documentSymbol" then require("nvim-navic").attach(client, buffer) end
      end)
    end,
    opts = function()
      return {
        separator = "  ",
        highlight = false,
        depth_limit = 7,
        icons = LazyVim.config.icons.kinds,
        lazy_update_context = true,
      }
    end,
  },

  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    cmd = "Precognition",
    opts = {},
    keys = {
      {
        "<leader>ue",
        "<cmd>Precognition toggle<CR>",
        desc = "Toggle precognition",
      },
    },
  },

  {
    "mason-org/mason.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.ui = {
        border = "rounded",
        backdrop = 100,
      }
    end,
  },

  {
    "echasnovski/mini.icons",
    event = "VeryLazy",
    opts = function(_, opts)
      local bg = LazyVim.color.hlcolor("Normal", "bg")
      LazyVim.color.hlset(
        "MiniIconsCyanLight",
        LazyVim.color.extand(
          "MiniIconsCyan",
          { bg = LazyVim.color.blend(LazyVim.color.hlcolor("MiniIconsCyan", "fg"), bg, 0.15) }
        )
      )
      LazyVim.color.hlset(
        "MiniIconsBlueLight",
        LazyVim.color.extand(
          "MiniIconsBlue",
          { bg = LazyVim.color.blend(LazyVim.color.hlcolor("MiniIconsBlue", "fg"), bg, 0.15) }
        )
      )
      LazyVim.color.hlset(
        "MiniIconsOrangeLight",
        LazyVim.color.extand(
          "MiniIconsOrange",
          { bg = LazyVim.color.blend(LazyVim.color.hlcolor("MiniIconsOrange", "fg"), bg, 0.15) }
        )
      )
      LazyVim.color.hlset(
        "MiniIconsPurpleLight",
        LazyVim.color.extand(
          "MiniIconsPurple",
          { bg = LazyVim.color.blend(LazyVim.color.hlcolor("MiniIconsPurple", "fg"), bg, 0.15) }
        )
      )
      LazyVim.color.hlset(
        "MiniIconsYellowLight",
        LazyVim.color.extand(
          "MiniIconsYellow",
          { bg = LazyVim.color.blend(LazyVim.color.hlcolor("MiniIconsYellow", "fg"), bg, 0.15) }
        )
      )
      LazyVim.color.hlset(
        "MiniIconsAzureLight",
        LazyVim.color.extand(
          "MiniIconsAzure",
          { bg = LazyVim.color.blend(LazyVim.color.hlcolor("MiniIconsAzure", "fg"), bg, 0.15) }
        )
      )
      LazyVim.color.hlset(
        "MiniIconsGreyLight",
        LazyVim.color.extand(
          "MiniIconsGrey",
          { bg = LazyVim.color.blend(LazyVim.color.hlcolor("MiniIconsGrey", "fg"), bg, 0.15) }
        )
      )
      LazyVim.color.hlset(
        "MiniIconsRedLight",
        LazyVim.color.extand(
          "MiniIconsRed",
          { bg = LazyVim.color.blend(LazyVim.color.hlcolor("MiniIconsRed", "fg"), bg, 0.15) }
        )
      )
      LazyVim.color.hlset(
        "MiniIconsGreenLight",
        LazyVim.color.extand(
          "MiniIconsGreen",
          { bg = LazyVim.color.blend(LazyVim.color.hlcolor("MiniIconsGreen", "fg"), bg, 0.15) }
        )
      )
    end,
  },

  {
    "saghen/blink.cmp",
    event = "VeryLazy",
    opts = function(_, opts)
      local mini = require "mini.icons"

      opts.keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      }
      opts.fuzzy = {
        implementation = "rust",
        sorts = { "score", "sort_text", "kind", "label" },
      }
      opts.completion.menu.draw = {
        padding = { 1, 2 },
        columns = { { "label", "label_description", gap = 10 }, { "kind_icon", "kind", "source_name" } },
        components = {
          kind_icon = {
            text = function(ctx)
              local kind_icon, _, _ = mini.get("lsp", ctx.kind)
              return "  " .. kind_icon .. "  "
            end,
            highlight = function(ctx)
              local _, hl, _ = mini.get("lsp", ctx.kind)
              return hl
            end,
          },
          kind = {
            highlight = function(ctx)
              local _, hl, _ = mini.get("lsp", ctx.kind)
              return hl
            end,
          },
        },
      }
    end,
  },
}
