return {

  {
    "LazyVim/LazyVim",
    event = "VeryLazy",
    priority = 100,
    dependencies = {
      {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        event = "VeryLazy",
        opts = function(_, opts)
          local utils = require "tokyonight.util"
          opts.style = "moon"
          opts.on_highlights = function(hl, colors)
            hl["@keyword.function.python"] = hl["@keyword"]
            hl["@variable.member.python"] = { fg = utils.lighten(colors.teal, 0.4), italic = true }
            hl["@lsp.type.selfParameter.python"] = { fg = colors.red, italic = true }
            hl["@lsp.type.decorator.python"] = { fg = colors.orange, italic = true }
            hl["@lsp.type.namespace.python"] = { fg = utils.lighten(colors.blue0, 0.2) }
            hl["@variable.parameter.python"] = { fg = colors.yellow, italic = true }
            hl["@keyword.conditional.python"] = hl["@keyword"]
            hl["@keyword.repeat.python"] = hl["@keyword"]
            hl["@keyword.exception.python"] = hl["@keyword"]
            hl["@keyword.operator.python"] = hl["@keyword"]
            hl["@constant.builtin.python"] = { fg = colors.magenta }
            hl["DiagnosticUnderlineError"] = { underline = false }
            hl["DiagnosticUnderlineWarn"] = { underline = false }
            hl["DiagnosticUnderlineInfo"] = { underline = false }
            hl["@constant.python"] = { fg = colors.red }
            hl["@comment.error"] = { fg = colors.red }
            hl["DiagnosticVirtualTextError"] = { fg = colors.red }
            hl["DiagnosticError"] = { fg = colors.red }
            hl["Error"] = { fg = colors.red }
            hl["ErrorMsg"] = { fg = colors.red }
            hl["SnacksNotifierTitleError"] = { fg = colors.red }
            hl["SnacksNotifierIconError"] = { fg = colors.red }
            hl["BufferLineFill"] = { bg = colors.bg_dark }
            hl["BufferLineSeparator"] = { fg = colors.bg_dark, bg = colors.bg_dark1 }
            hl["BufferLineSeparatorSelected"] = { fg = colors.bg_dark, bg = colors.bg }
            hl["BufferLineSeparatorVisible"] = { fg = colors.bg_dark, bg = colors.bg }
            hl["BufferLineBufferVisible"] = { fg = colors.fg_dark, bg = colors.bg, italic = true }
            hl["BufferLineCloseButtonVisible"] = { fg = colors.fg_dark, bg = colors.bg, italic = true }
            hl["BufferLineMiniIconsAzureInactive"] = { fg = colors.cyan, bg = colors.bg }
            hl["DiagnosticVirtualTextError"] = { fg = utils.blend(colors.red, 0.6, colors.bg), italic = true }
            hl["DiagnosticVirtualTextWarn"] = { fg = utils.blend(colors.yellow, 0.6, colors.bg), italic = true }
            hl["DiagnosticVirtualTextInfo"] = { fg = utils.blend(colors.blue, 0.6, colors.bg), italic = true }
            hl["DiagnosticVirtualTextHint"] = { fg = utils.blend(colors.cyan, 0.6, colors.bg), italic = true }
            hl["MiniIconsCyanLight"] = { bg = utils.blend(colors.cyan, 0.1, colors.bg), fg = colors.cyan }
            hl["MiniIconsBlueLight"] = { bg = utils.blend(colors.blue, 0.1, colors.bg), fg = colors.blue }
            hl["MiniIconsOrangeLight"] = { bg = utils.blend(colors.orange, 0.1, colors.bg), fg = colors.orange }
            hl["MiniIconsPurpleLight"] = { bg = utils.blend(colors.purple, 0.1, colors.bg), fg = colors.purple }
            hl["MiniIconsYellowLight"] = { bg = utils.blend(colors.yellow, 0.1, colors.bg), fg = colors.yellow }
            hl["MiniIconsAzureLight"] = { bg = utils.blend(colors.teal, 0.1, colors.bg), fg = colors.teal }
            hl["MiniIconsGreyLight"] = { bg = utils.blend(colors.comment, 0.1, colors.bg), fg = colors.comment }
            hl["MiniIconsRedLight"] = { bg = utils.blend(colors.red, 0.1, colors.bg), fg = colors.red }
            hl["MiniIconsGreenLight"] = { bg = utils.blend(colors.green, 0.1, colors.bg), fg = colors.green }
          end
          opts.cache = true
          opts.plugins = {
            all = true,
            auto = true,
          }
        end,
      },
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
      colorscheme = "tokyonight",
    },
    specs = {
      { "rose-pine", enabled = false },
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
          suffix = function(diagnostic) return string.format(" (%s)", diagnostic.code), "NonText" end,
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
          { "<leader>t", group = "tools", icon = { icon = " ", color = "blue" } },
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
        "mason.nvim",
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
            [[  ███                                  ███                  ]],
            [[ ░░░███                               ░░░                   ]],
            [[   ░░░███      ████████   █████ █████ ████  █████████████   ]],
            [[     ░░░███   ░░███░░███ ░░███ ░░███ ░░███ ░░███░░███░░███  ]],
            [[      ███░     ░███ ░███  ░███  ░███  ░███  ░███ ░███ ░███  ]],
            [[    ███░       ░███ ░███  ░░███ ███   ░███  ░███ ░███ ░███  ]],
            [[  ███░         ████ █████  ░░█████    █████ █████░███ █████ ]],
            [[ ░░░          ░░░░ ░░░░░    ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
          }, "\n"),
        },
      },
      image = { enabled = false },
      notifier = { level = vim.log.levels.INFO },
      picker = {
        sources = {
          explorer = {
            prompt = " > ",
            title = "Explorer",
            formatters = {
              file = {
                git_status_hl = false,
              },
            },
            layout = {
              preset = "select",
              layout = {
                backdrop = true,
                height = 0.6,
                width = 0.4,
              },
            },
            auto_close = true,
            diagnostics = false,
            jump = { close = true },
            ignored = {
              "**/.venv",
            },
            exclude = {
              "**/__pycache__",
              "**/.*_cache",
            },
            include = {
              ".pre-commit-config.*",
              ".gitignore",
              ".env.*",
              ".env",
              ".ci",
              ".github",
              ".dockerignore",
              ".luarc.json",
              ".github",
              ".devcontainer",
            },
          },
        },
        icons = {
          git = {
            enabled = true,
            addedd = "",
            deleted = "",
            modified = "󰜥",
            remaned = "", -- optional: 
            staged = "", -- optional: 
            conflict = "", -- optional: 
            ignored = "", -- optional: 
            unstaged = "", -- optional: 
            untracked = "", -- optional: 
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
      opts.options.separator_style = "slant"
      opts.options.enforce_regular_tabs = true
      opts.options.diagnostics = false
      opts.options.offsets = {
        {
          filetype = "snacks_layout_box",
          highlight = "SnacksPickerInputBorder",
          text_align = "center",
        },
      }
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local icons = LazyVim.config.icons

      opts.components = {
        statusline = {
          mode = {
            function() return "nvim" end,
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
            color = function() return { fg = Snacks.util.color("lualine_b_normal", "fg") } end,
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
              for _, client in pairs(vim.lsp.get_clients { bufnr = 0 }) do
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
              for _, linter in pairs(LazyVim.misc.linters()) do
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
            color = function() return { fg = Snacks.util.color("lualine_b_normal", "fg") } end,
            draw_empty = false,
          },
        },
      }

      opts.sections = {
        lualine_a = { opts.components.statusline.mode },
        lualine_b = { opts.components.statusline.gitbranch },
        lualine_c = { opts.components.statusline.filepath, opts.components.statusline.gitdiff },
        lualine_x = { opts.components.statusline.diagnostics, opts.components.statusline.langtools },
        lualine_y = { opts.components.statusline.filetype },
        lualine_z = { opts.components.statusline.location },
      }
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = function(_, opts) opts.presets.bottom_search = false end,
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
    "mason.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.ui = {
        border = "rounded",
        backdrop = 100,
      }
    end,
  },

  {
    "saghen/blink.cmp",
    event = "VeryLazy",
    opts = function(_, opts)
      local mini = require "mini.icons"

      opts.cmdline = { enabled = false }
      opts.keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      }
      opts.fuzzy = {
        implementation = "rust",
        sorts = { "exact", "score", "sort_text" },
      }
      opts.completion.documentation.window = {
        min_width = 60,
        max_width = 120,
        border = "rounded",
      }
      opts.completion.menu.draw = {
        padding = { 0, 1 },
        columns = {
          { "kind_icon" },
          { "label", "label_description" },
          { "kind" },
        },
        components = {
          kind_icon = {
            text = function(ctx)
              local kind_icon, _, _ = mini.get("lsp", ctx.kind)
              return "  " .. kind_icon .. "  "
            end,
            highlight = function(ctx)
              local _, hl, _ = mini.get("lsp", ctx.kind)
              return hl .. "Light"
            end,
          },
          kind = {
            text = function(ctx) return " " .. ctx.kind end,
            highlight = function(ctx)
              local _, hl, _ = mini.get("lsp", ctx.kind)
              return hl
            end,
          },
          label_description = {
            highlight = "NonText",
          },
          label = {
            width = { min = 30, max = 60 },
          },
        },
      }
    end,
  },

  {
    "mvllow/modes.nvim",
    -- tag = "v0.2.1",
    commit = "0932ba4",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.line_opacity = 0.18
      opts.set_cursor = true
    end,
  },
}
