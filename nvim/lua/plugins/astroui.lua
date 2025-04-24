return {

  ---@type LazySpec
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      -- change colorscheme
      colorscheme = "rose-pine",
      -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
      highlights = {
        init = { -- this table overrides highlights in all themes
          -- Normal = { bg = "#000000" },
        },
        astrodark = { -- a table of overrides/changes when applying the astrotheme theme
          -- Normal = { bg = "#000000" },
        },
      },
      -- Icons can be configured throughout the interface
      icons = {
        -- configure the loading of the lsp in the status line
        LSPLoading1 = "⠋",
        LSPLoading2 = "⠙",
        LSPLoading3 = "⠹",
        LSPLoading4 = "⠸",
        LSPLoading5 = "⠼",
        LSPLoading6 = "⠴",
        LSPLoading7 = "⠦",
        LSPLoading8 = "⠧",
        LSPLoading9 = "⠇",
        LSPLoading10 = "⠏",
      },
    },
  },

  ---@type LazySpec
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            [[                            ####+++###                            ]],
            [[                        ##-.          .+##                        ]],
            [[                       #-                -#                       ]],
            [[                     #+.                  .+#                     ]],
            [[                     +.                     +                     ]],
            [[           #--+#    #.            .#####-   .#    #+--#           ]],
            [[          #-.  -    +   .###     -########   +#   -  ..#          ]],
            [[          #-    +  #-   #####    #########   -#  +    .#          ]],
            [[           +     .-#-    ##-     -########   -#-.     +           ]],
            [[           #-      ..              +####.    .-      -#           ]],
            [[            #.     -.                        .-     .+            ]],
            [[              -    -.   .################.   .+    -              ]],
            [[               -   +.      .##########-      .#   -               ]],
            [[                +- +        +##+##+##+.       +.-                 ]],
            [[                  #-        ++------++.       -#                  ]],
            [[                  +.        +++----++#        .#                  ]],
            [[                 #.         .+#######.         -#                 ]],
            [[                #-             .--.             -#                ]],
            [[               #-                                -#               ]],
            [[              #-                                  -#              ]],
            [[             +.       .---.            .---.       .#             ]],
            [[             #+-.--#        #+-....-+#        #+-..+#             ]],
          }, "\n"),
        },
      },
      notifier = {
        level = vim.log.levels.INFO,
      },
      image = { enabled = false },
    },
  },

  ---@type LazySpec
  {
    "rose-pine/neovim",
    name = "rose-pine",
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
        ["@lsp.type.decorator.python"] = { italic = true },
        ["@lsp.type.class.python"] = { fg = "foam" },
        ["@module.python"] = { fg = "lfoam" },
        ["@attribute.python"] = { fg = "iris", italic = true },
      }
    end,
  },

  ---@type LazySpec
  {
    "mvllow/modes.nvim",
    dependencies = { "rose-pine" },
    opts = function(_, opts)
      opts.line_opacity = 0.2
      opts.set_cursor = false
    end,
  },

  ---@type LazySpec
  {
    "rebelot/heirline.nvim",
    dependencies = { "rose-pine" },
    opts = function(_, opts)
      local utils = require "heirline.utils"
      local conditions = require "heirline.conditions"
      local palette = require "rose-pine.palette"

      vim.api.nvim_set_hl(0, "HeirlineTablineActiveTab", { fg = palette.text, bg = palette.base })
      vim.api.nvim_set_hl(0, "HeirlineTablineInactiveTab", { fg = palette.muted, bg = palette.overlay })
      vim.api.nvim_set_hl(0, "HeirlineTabline", { link = "StatusLine" })
      vim.api.nvim_set_hl(0, "HeirlineTablineTabCloseButton", { fg = palette.love })
      vim.api.nvim_set_hl(0, "HeirlineStatusline", { fg = palette.text, bg = palette.surface })
      vim.api.nvim_set_hl(0, "HeirlineStatuslineLSP", { fg = palette.subtle })
      vim.api.nvim_set_hl(0, "HeirlineStatuslineSep", { fg = palette.muted })

      local modecolors = {
        n = palette.pine, -- normal
        i = palette.foam, -- insert
        v = palette.iris, -- visual
        V = palette.iris, -- visual line
        [""] = palette.iris, -- visual block
        c = palette.subtle, -- command
        no = palette.foam,
        s = palette.gold, -- select
        S = palette.gold, -- select line
        [""] = palette.gold, -- select block
        ic = palette.foam,
        R = palette.iris, -- replace
        Rv = palette.iris, -- virtual replace
        cv = palette.subtle,
        ce = palette.subtle,
        r = palette.subtle,
        rm = palette.subtle,
        ["r?"] = palette.subtle,
        ["!"] = palette.subtle,
        t = palette.leaf, -- terminal job
      }

      local components = {

        statusline = {

          border = {
            provider = " ",
            hl = function() return { bg = modecolors[vim.fn.mode(1):sub(1, 1)] } end,
          },
          fill = { provider = "%=" },

          separator = function(params)
            return {
              provider = "⏽",
              hl = "HeirlineStatuslineSep",
              condition = params.condition,
            }
          end,

          mode = {
            provider = function() return "   󰊠   " end, -- or 󰣙 / 󰣘
            hl = function() return { fg = modecolors[vim.fn.mode(1):sub(1, 1)] } end,
            update = {
              "ModeChanged",
              pattern = "*:*",
              callback = vim.schedule_wrap(function() vim.cmd "redrawstatus" end),
            },
          },

          git = {
            condition = conditions.is_git_repo,
            init = function(self) self.statusdict = vim.b.gitsigns_status_dict end,
            hl = "MoreMsg",
            { provider = "  " },
            {
              provider = function(self) return " " .. self.statusdict.head end,
              hl = { bold = true },
            },
            {
              condition = function() return vim.b.gitsigns_status ~= nil and vim.b.gitsigns_status ~= "" end,
              provider = "    ",
              hl = "HeirlineStatuslineSep",
            },
            {
              provider = function(self)
                return (self.statusdict.added or 0) > 0 and ("+" .. self.statusdict.added .. " ")
              end,
              hl = { fg = utils.get_highlight("GitSignsAdd").fg },
            },
            {
              provider = function(self)
                return (self.statusdict.changed or 0) > 0 and ("~" .. self.statusdict.changed .. " ")
              end,
              hl = { fg = utils.get_highlight("GitSignsChange").fg },
            },
            {
              provider = function(self)
                return (self.statusdict.removed or 0) > 0 and ("-" .. self.statusdict.removed) --- @format disable
              end,
              hl = { fg = utils.get_highlight("GitSignsDelete").fg },
            },
            { provider = "  " },
          },

          position = { provider = "   %l:%c   " },

          filetype = {
            init = function(self)
              self.filetype = vim.bo.filetype
              self.icon, self.iconcolor = require("nvim-web-devicons").get_icon_color_by_filetype(self.filetype)
            end,
            { provider = "  " },
            {
              provider = function(self) return self.icon and self.icon .. " " end,
              hl = function(self) return { fg = self.iconcolor } end,
            },
            {
              provider = function(self) return self.filetype end,
            },
            { provider = "  " },
          },

          lspinfo = {
            condition = conditions.lsp_attached,
            update = { "LspAttach", "LspDetach" },
            hl = "HeirlineStatuslineLSP",
            { provider = "  " },
            { provider = " : " },
            {
              provider = function()
                local msg = ""
                local attached = vim.lsp.get_clients { bufnr = 0 }
                if #attached == 0 then return msg end
                local bufft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                local clients = { lsp = {}, nullls = {} }
                for _, client in pairs(attached) do
                  if client.name ~= "copilot" and client.name ~= "null-ls" then
                    table.insert(clients.lsp, client.name)
                  end
                end
                local null_ls_s, null_ls = pcall(require, "null-ls")
                if null_ls_s then
                  local sources = null_ls.get_sources()
                  for _, source in ipairs(sources) do
                    if source._validated then
                      for ftname, ftactive in pairs(source.filetypes) do
                        if ftname == bufft and ftactive then table.insert(clients.nullls, source.name) end
                      end
                    end
                  end
                end
                msg = msg .. table.concat(clients.lsp, ", ")
                if #clients.nullls ~= 0 then
                  msg = msg .. " [" .. table.concat(clients.nullls, ", ") .. "]" ---@format disable
                end
                return msg
              end,
            },
            { provider = "  " },
          },

          diagnostics = {
            condition = conditions.has_diagnostics,
            update = { "DiagnosticChanged", "BufEnter" },
            static = {
              icons = {
                error = "󰅚 ",
                warn = "󰀪 ",
                info = "󰋽 ",
                hint = "󰌶 ",
              },
            },
            init = function(self)
              self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
              self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
              self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
              self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
            end,
            { provider = "  " },
            {
              provider = function(self) return self.errors > 0 and (self.icons.error .. self.errors .. " ") end,
              hl = { fg = utils.get_highlight("DiagnosticError").fg },
            },
            {
              provider = function(self) return self.warnings > 0 and (self.icons.warn .. self.warnings .. " ") end,
              hl = { fg = utils.get_highlight("DiagnosticWarn").fg },
            },
            {
              provider = function(self) return self.info > 0 and (self.icons.info .. self.info .. " ") end,
              hl = { fg = utils.get_highlight("DiagnosticInfo").fg },
            },
            {
              provider = function(self) return self.hints > 0 and (self.icons.hint .. self.hints .. " ") end,
              hl = { fg = utils.get_highlight("DiagnosticHint").fg },
            },
            { provider = "  " },
            { provider = "", hl = "HeirlineStatuslineSep" },
          },
        },

        tabline = {

          offset = { -- tabline offset (for neo-tree)
            condition = function(self)
              local win = vim.api.nvim_tabpage_list_wins(0)[1]
              local bufnr = vim.api.nvim_win_get_buf(win)
              self.winid = win
              if vim.bo[bufnr].filetype == "neo-tree" then
                self.title = "Files"
                return true
              end
            end,
            {
              provider = function(self)
                local title = self.title
                local width = vim.api.nvim_win_get_width(self.winid)
                local pad = math.ceil((width - #title) / 2)
                return string.rep(" ", pad) .. title .. string.rep(" ", pad + 1 - math.fmod((width - #title), 2))
              end,
            },
          },

          bufline = {
            {
              provider = "",
              hl = function(self)
                return {
                  bg = utils.get_highlight("HeirlineTabline").bg,
                  fg = self.is_active and utils.get_highlight("HeirlineTablineActiveTab").bg
                    or utils.get_highlight("HeirlineTablineInactiveTab").bg,
                }
              end,
            },
            {
              provider = "   ",
              hl = function(self) return self.is_active and "HeirlineTablineActiveTab" or "HeirlineTablineInactiveTab" end,
            },
            { -- filename block
              init = function(self) self.filename = vim.api.nvim_buf_get_name(self.bufnr) end,
              hl = function(self) return self.is_active and "HeirlineTablineActiveTab" or "HeirlineTablineInactiveTab" end,
              on_click = {
                callback = function(_, minwid, _, _) vim.api.nvim_win_set_buf(0, minwid) end,
                minwid = function(self) return self.bufnr end,
                name = "heirline_tabline_buffer_callback",
              },
              { -- icon
                init = function(self)
                  local extension = vim.fn.fnamemodify(self.filename, ":e")
                  self.icon, self.icon_color =
                    require("nvim-web-devicons").get_icon_color(self.filename, extension, { default = true })
                end,
                provider = function(self) return self.icon and (self.icon .. "  ") end,
                hl = function(self) return self.is_active and { fg = self.icon_color } end,
              },
              { -- filename
                provider = function(self)
                  return (self.filename == "" and "[Untitled]" or vim.fn.fnamemodify(self.filename, ":t")) .. " "
                end,
                hl = function(self) return { bold = self.is_active or self.is_visible, italic = true } end,
              },
              { -- flags
                {
                  condition = function(self) return vim.api.nvim_get_option_value("modified", { buf = self.bufnr }) end,
                  provider = "  ",
                  hl = function() end,
                },
                {
                  condition = function(self)
                    return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
                      or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
                  end,
                  provider = function(self)
                    return vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" and "  "
                      or ""
                  end,
                  hl = function(self) return self.is_active and "SpecialKey" end,
                },
              },
            },
            { -- close button
              condition = function(self) return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr }) end,
              {
                provider = " ",
                hl = function(self)
                  return self.is_active and "HeirlineTablineActiveTab" or "HeirlineTablineInactiveTab"
                end,
              },
              {
                provider = " ",
                hl = function(self) return self.is_active and "HeirlineTablineTabCloseButton" end,
                on_click = {
                  callback = function(_, minwid)
                    vim.schedule(function()
                      vim.api.nvim_buf_delete(minwid, { force = false })
                      vim.cmd.redrawtabline()
                    end)
                  end,
                  minwid = function(self) return self.bufnr end,
                  name = "heirline_tabline_close_buffer_callback",
                },
              },
              hl = function(self) return self.is_active and "HeirlineTablineActiveTab" or "HeirlineTablineInactiveTab" end,
            },
            {
              provider = " ",
              hl = function(self) return self.is_active and "HeirlineTablineActiveTab" or "HeirlineTablineInactiveTab" end,
            },
            {
              provider = "",
              hl = function(self)
                return {
                  bg = utils.get_highlight("HeirlineTabline").bg,
                  fg = self.is_active and utils.get_highlight("HeirlineTablineActiveTab").bg
                    or utils.get_highlight("HeirlineTablineInactiveTab").bg,
                }
              end,
            },
          },
        },
      }

      opts.statusline = {
        hl = "HeirlineStatusline",
        {
          components.statusline.border,
          components.statusline.mode,
          components.statusline.separator {},
          components.statusline.git,
          components.statusline.fill,
          components.statusline.diagnostics,
          components.statusline.lspinfo,
          components.statusline.separator { condition = conditions.lsp_attached },
          components.statusline.filetype,
          components.statusline.separator {},
          components.statusline.position,
          components.statusline.border,
        },
      }

      opts.tabline = {
        components.tabline.offset,
        { utils.make_buflist { components.tabline.bufline } },
      }
    end,
  },

  ---@type LazySpec
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      source_selector = {
        winbar = false,
        statusline = false,
        sources = { { source = "filesystem" } },
      },
      filesystem = {
        filtered_items = {
          visible = false,
          show_hidden_count = true,
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_by_name = {
            "__pycache__",
          },
          always_show = {
            ".gitignore",
            ".env",
          },
        },
        use_libuv_file_watcher = true,
      },
      event_handlers = {},
      window = { width = 40 },
      enable_diagnostics = false,
      default_component_configs = {
        git_status = {
          symbols = {
            addedd = "",
            deleted = "",
            modified = "󰜥",
            remaned = "", -- 
            staged = "", -- 
            conflict = "", -- 
            ignored = "", -- 
            unstaged = "", -- 
            untracked = "", -- 
          },
        },
        diagnostics = { symbols = false },
      },
    },
  },

  ---@type LazySpec
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = function(_, opts)
      local utils = require "astrocore"
      return utils.extend_tbl(opts, {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = false,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = utils.is_available "inc-rename.nvim",
          lsp_doc_border = false,
        },
      })
    end,
    specs = {
      ---@type LazySpec
      {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
          if opts.ensure_installed ~= "all" then
            opts.ensure_installed = require("astrocore").list_insert_unique(
              opts.ensure_installed,
              { "bash", "markdown", "markdown_inline", "regex", "vim" }
            )
          end
        end,
      },
      ---@type LazySpec
      {
        "AstroNvim/astrolsp",
        optional = true,
        ---@param opts AstroLSPOpts
        opts = function(_, opts)
          local noice_opts = require("astrocore").plugin_opts "noice.nvim"
          -- disable the necessary handlers in AstroLSP
          if not opts.defaults then opts.defaults = {} end
          -- TODO: remove lsp_handlers when dropping support for AstroNvim v4
          if not opts.lsp_handlers then opts.lsp_handlers = {} end
          if vim.tbl_get(noice_opts, "lsp", "hover", "enabled") ~= false then
            opts.defaults.hover = false
            opts.lsp_handlers["textDocument/hover"] = false
          end
          if vim.tbl_get(noice_opts, "lsp", "signature", "enabled") ~= false then
            opts.defaults.signature_help = false
            opts.lsp_handlers["textDocument/signatureHelp"] = false
            if not opts.features then opts.features = {} end
            opts.features.signature_help = false
          end
        end,
      },
      ---@type LazySpec
      {
        "rebelot/heirline.nvim",
        optional = true,
        opts = function(_, opts)
          local noice_opts = require("astrocore").plugin_opts "noice.nvim"
          if vim.tbl_get(noice_opts, "lsp", "progress", "enabled") ~= false then -- check if lsp progress is enabled
            opts.statusline[9] = require("astroui.status").component.lsp { lsp_progress = false }
          end
        end,
      },
      ---@type LazySpec
      {
        "folke/edgy.nvim",
        optional = true,
        opts = function(_, opts)
          if not opts.bottom then opts.bottom = {} end
          table.insert(opts.bottom, {
            ft = "noice",
            size = { height = 0.4 },
            filter = function(_, win) return vim.api.nvim_win_get_config(win).relative == "" end,
          })
        end,
      },
    },
  },
}
