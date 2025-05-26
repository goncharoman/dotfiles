local keymap = vim.keymap

-- quick save
keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Write buffer", remap = true })

-- commenting
keymap.set("n", "<leader>/", "gcc", { desc = "Toggle comment line", remap = true })
keymap.set("x", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- indenting
keymap.set("x", "<Tab>", ">gv", { desc = "Indent line" })
keymap.set("x", "<S-Tab>", "<gv", { desc = "Unindent line" })

-- close current buffer
keymap.set("n", "<leader>x", function()
  Snacks.bufdelete()
end, { desc = "Close buffer" })

--  diagnostics/quicklist group
keymap.set("n", "<leader>lx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
keymap.set(
  "n",
  "<leader>lX",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { desc = "Buffer Diagnostics (Trouble)" }
)
keymap.set("n", "<leader>lL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
keymap.set("n", "<leader>lQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
keymap.set("n", "<leader>lt", "<cmd>Trouble todo toggle<cr>", { desc = "Todo (Trouble)" })
keymap.set(
  "n",
  "<leader>lT",
  "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",
  { desc = "Todo/Fix/Fixme (Trouble)" }
)
keymap.set("n", "<leader>ll", function()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Location List" })
keymap.set("n", "<leader>lq", function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Quickfix List" })

-- WARNING disable default mapping
-- disable windows (+w) group keymaps
keymap.del("n", "<leader>wm")
keymap.del("n", "<leader>wd")

-- disable diagnostics/quicklist keymaps
keymap.del("n", "<leader>xl")
keymap.del("n", "<leader>xq")

-- diable ff for space-space
keymap.del("n", "<leader><space>")

-- disable Lazy keymap
keymap.del("n", "<leader>l")
keymap.del("n", "<leader>L")
