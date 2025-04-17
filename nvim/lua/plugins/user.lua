---@type LazySpec
return {

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  {
    "sindrets/diffview.nvim",
    opts = function(_, opts)
      local actions = require "diffview.actions"
      opts.view = {
        merge_tool = {
          layout = "diff3_mixed",
          disable_diagnostics = true,
          winbar_info = true,
        },
      }
      opts.keymaps = {
        view = {
          {
            "n",
            "<leader>mo",
            actions.conflict_choose "ours",
            { desc = "Choose the OURS version of a conflict" },
          },
          {
            "n",
            "<leader>mt",
            actions.conflict_choose "theirs",
            { desc = "Choose the THEIRS version of a conflict" },
          },
          {
            "n",
            "<leader>mb",
            actions.conflict_choose "base",
            { desc = "Choose the BASE version of a conflict" },
          },
          {
            "n",
            "<leader>ma",
            actions.conflict_choose "all",
            { desc = "Choose all the versions of a conflict" },
          },
          { "n", "dx", actions.conflict_choose "none", { desc = "Delete the conflict region" } },
          {
            "n",
            "<leader>mO",
            actions.conflict_choose_all "ours",
            { desc = "Choose the OURS version of a conflict for the whole file" },
          },
          {
            "n",
            "<leader>mT",
            actions.conflict_choose_all "theirs",
            { desc = "Choose the THEIRS version of a conflict for the whole file" },
          },
          {
            "n",
            "<leader>mB",
            actions.conflict_choose_all "base",
            { desc = "Choose the BASE version of a conflict for the whole file" },
          },
          {
            "n",
            "<leader>mA",
            actions.conflict_choose_all "all",
            { desc = "Choose all the versions of a conflict for the whole file" },
          },
          {
            "n",
            "dX",
            actions.conflict_choose_all "none",
            { desc = "Delete the conflict region for the whole file" },
          },
        },
      }
    end,
  },
}
