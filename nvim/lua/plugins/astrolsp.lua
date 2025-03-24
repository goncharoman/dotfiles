---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      autoformat = true, -- enable or disable auto formatting on start
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = true, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    servers = {}, -- enable servers that you already have installed without mason
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
    },
  },
  -- customize how language servers are attached
  handlers = {},
  -- Configure buffer local auto commands to add when attaching a language server
  autocmds = {
    lsp_document_highlight = {
      cond = "textDocument/documentHighlight",
      {
        event = { "CursorHold", "CursorHoldI" },
        desc = "Document Highlighting",
        callback = function() vim.lsp.buf.document_highlight() end,
      },
      {
        event = { "CursorMoved", "CursorMovedI", "BufLeave" },
        desc = "Document Highlighting Clear",
        callback = function() vim.lsp.buf.clear_references() end,
      },
    },
  },
  -- mappings to be set up on attaching of a language server
  mappings = {
    n = {
      gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
      gD = {
        function() vim.lsp.buf.declaration() end,
        desc = "Declaration of current symbol",
        cond = "textDocument/declaration",
      },
      ["<Leader>uY"] = {
        function() require("astrolsp.toggles").buffer_semantic_tokens() end,
        desc = "Toggle LSP semantic highlight (buffer)",
        cond = function(client) return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens end,
      },
    },
  },
}
