-- add custom helpers
---@diagnostic disable: inject-field
LazyVim.color = require "utils.color"
LazyVim.lint = require "utils.lint"
LazyVim.commands = require "utils.commands"

vim.g.ai_cmp = false
vim.g.lazyvim_cmp = "blink.cmp"

-- lsp/formatters/linters aliases to display in the statusline
vim.g.aliases = {}
