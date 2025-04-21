---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = true, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          "python", -- disable autoformatting for python (see python augroup)
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
      },
      timeout_ms = 1000, -- default format timeout
    },
    -- enable servers that you already have installed without mason
    servers = {},
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      basedpyright = {
        settings = {
          basedpyright = {
            disableOrganizeImports = true,
            analisis = {
              typeCheckingMode = "basic",
              diagnosticMode = "workspace",
              autoImportCompletions = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      },
      ruff = {
        cmd_env = { RUFF_TRACE = "messages" },
        init_options = { logLevel = "error" },
      },
      tinymist = {
        settings = {
          formatterMode = "typestyle",
        },
      },
      clangd = {
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "hpp" },
      },
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        gofumpt = true,
      },
    },
    -- customize how language servers are attached
    handlers = {},
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      python = {
        cond = function() return vim.bo.ft == "python" end,
        {
          event = { "BufWritePre" },
          desc = "Ruff auto-'fixAll' on save",
          callback = function(_) vim.lsp.buf.code_action { context = { only = { "source.fixAll" } }, apply = true } end,
        },
      },
      lsp_codelens_refresh = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/codeLens",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "InsertLeave", "BufEnter" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        gd = {
          function() require("snacks").picker.lsp_definitions() end,
          desc = "Definition of current symbol",
          cond = "textDocument/declaration",
        },
        gD = {
          function() require("snacks").picker.lsp_declarations() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        gr = {
          function() require("snacks").picker.lsp_references() end,
          desc = "References of current symbol",
          cond = "textDocument/declaration",
        },
        gI = {
          function() require("snacks").picker.lsp_implementations() end,
          desc = "Implementation of current symbol",
          cond = "textDocument/declaration",
        },
        gy = {
          function() require("snacks").picker.lsp_type_definitions() end,
          desc = "Type deifinition of current symbol",
          cond = "textDocument/declaration",
        },
        ["<Leader>ss"] = {
          function() require("snacks").picker.lsp_symbols() end,
          desc = "LSP symbols",
          cond = "textDocument/declaration",
        },
        ["<Leader>sS"] = {
          function() require("snacks").picker.lsp_workspace_symbols() end,
          desc = "LSP workspace symbols",
          cond = "textDocument/declaration",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },
      },
    },
  },
}
