-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")

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

vim.keymap.set({ "n" }, "<leader>qc", "<Cmd>:q<CR>")

-- go to head/tail of a line
vim.keymap.set({ "n" }, "<M-S-left>", "^")
vim.keymap.set({ "n" }, "<M-S-right>", "$")

-- fast entter command
vim.keymap.set("n", ";", ":")

-- fast comment
vim.keymap.set("n", "<M-/>", "gcc")

-- fast show dashboard
vim.keymap.set({ "n" }, "<leader>;", "<cmd>Dashboard<CR>")

-- Resize window fastly
vim.keymap.set({ "n" }, "<M-up>", ":res -5<cr>")
vim.keymap.set({ "n" }, "<M-down>", ":res +5<cr>")
vim.keymap.set({ "n" }, "<M-left>", ":vertical resize+10<cr>")
vim.keymap.set({ "n" }, "<M-right>", ":vertical resize-10<cr>")

-- Go to window fastly
vim.keymap.set({ "n" }, "<leader><up>", "<C-w>k")
vim.keymap.set({ "n" }, "<leader><down>", "<C-w>j")
vim.keymap.set({ "n" }, "<leader><left>", "<C-w>h")
vim.keymap.set({ "n" }, "<leader><right>", "<C-w>l")

-- zen mode
vim.keymap.set({ "n" }, "<C-z>", "<Cmd>:ZenMode<CR>")

-- ai
wk.register({
  a = {
    name = "ai",
    o = { "<cmd>:NeoAI<CR>", "Toggle Open" },
    c = { "<cmd>:NeoAIContext<CR>", "Toggle Open Context" },
    i = { "<cmd>:NeoAIInject<CR>", "Toggle Inject" },
    g = { "<cmd>:NeoAIInjectContext<CR>", "Toggle Inject Context" },
  },
}, { prefix = "<leader>" })
