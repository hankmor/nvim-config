-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- dap keymapping to Jetbrains
local dap = require("dap")
vim.keymap.set("n", "<F8>", function()
  dap.step_over()
end)
vim.keymap.set("n", "<F7>", function()
  dap.step_into()
end)
vim.keymap.set("n", "<F9>", function()
  dap.step_out()
end)
vim.keymap.set("n", "<F10>", function()
  dap.continue()
end)

-- go to head/tail of a line
vim.keymap.set({ "n", "i" }, "<M-S-left>", "^")
vim.keymap.set({ "n", "i" }, "<M-S-right>", "$")

-- fast entter command
vim.keymap.set("n", ";", ":")

-- fast comment
vim.keymap.set("n", "<leader>/", "<cmd>gcc<CR>")

-- fast show dashboard
vim.keymap.set({ "n", "i" }, "<leader>;", "<cmd>Dashboard<CR>")

-- Resize window fastly
vim.keymap.set({ "n", "i" }, "<M-up>", ":res -5<cr>")
vim.keymap.set({ "n", "i" }, "<M-down>", ":res +5<cr>")
vim.keymap.set({ "n", "i" }, "<M-left>", ":vertical resize+5<cr>")
vim.keymap.set({ "n", "i" }, "<M-right>", ":vertical resize-5<cr>")

-- Go to window fastly
vim.keymap.set({ "n", "i" }, "<leader><up>", "<C-w>k")
vim.keymap.set({ "n", "i" }, "<leader><down>", "<C-w>j")
vim.keymap.set({ "n", "i" }, "<leader><left>", "<C-w>h")
vim.keymap.set({ "n", "i" }, "<leader><right>", "<C-w>l")

-- zen mode
vim.keymap.set({ "n", "i" }, "<C-z>", "<Cmd>:ZenMode<CR>")
