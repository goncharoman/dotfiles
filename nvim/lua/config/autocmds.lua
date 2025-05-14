LazyVim.commands.autocmd("startup", {
  event = { "VimEnter" },
  callback = function() require("precognition").hide() end,
})
