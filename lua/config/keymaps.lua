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
vim.keymap.set({ "n", "v" }, "<M-S-left>", "^")
vim.keymap.set({ "n", "v" }, "<M-S-right>", "$")
vim.keymap.set({ "n", "v" }, "<M-h>", "^")
vim.keymap.set({ "n", "v" }, "<M-l>", "$")

-- fast entter command
vim.keymap.set("n", ";", ":")

-- fast comment
-- vim.keymap.set({ "n", "v" }, "<M-/>", "gcc", { remap = true })

-- fast show dashboard
vim.keymap.set({ "n" }, "<leader>;", "<cmd>Dashboard<CR>")

-- Resize window fastly
vim.keymap.set({ "n" }, "<M-up>", ":res -5<cr>")
vim.keymap.set({ "n" }, "<M-down>", ":res +5<cr>")
vim.keymap.set({ "n" }, "<M-left>", ":vertical resize+10<cr>")
vim.keymap.set({ "n" }, "<M-right>", ":vertical resize-10<cr>")
vim.keymap.set({ "n" }, "<M-J>", ":res -5<cr>")
vim.keymap.set({ "n" }, "<M-K>", ":res +5<cr>")
vim.keymap.set({ "n" }, "<M-H>", ":vertical resize+10<cr>")
vim.keymap.set({ "n" }, "<M-L>", ":vertical resize-10<cr>")

-- Go to window fastly
vim.keymap.set({ "n" }, "<leader><up>", "<C-w>k")
vim.keymap.set({ "n" }, "<leader><down>", "<C-w>j")
vim.keymap.set({ "n" }, "<leader><left>", "<C-w>h")
vim.keymap.set({ "n" }, "<leader><right>", "<C-w>l")

-- zen mode
vim.keymap.set({ "n" }, "<C-z>", "<Cmd>:ZenMode<CR>")

-- ai
wk.add({
  {
    { "<leader>a", group = "ai" },
    { "<leader>ao", "<cmd>:NeoAI<CR>", desc = "Toggle open" },
    { "<leader>ac", "<cmd>:NeoAIContext<CR>", desc = "Toggle open context" },
    { "<leader>ai", "<cmd>:NeoAIInject<CR>", desc = "Toggle inject" },
    { "<leader>ag", "<cmd>:NeoAIInjectContext<CR>", desc = "Toggle inject context" },
  },
})

-- rest http
wk.add({
  { "<leader>h", group = "http", icon = "󰌷" },
  { "<leader>he", "<cmd>lua require('telescope').extensions.rest.select_env()<CR>", desc = "Select env file" },
  { "<leader>hr", "<cmd>Rest run<cr>", desc = "Run request under the cursor" },
  { "<leader>hl", "<cmd>Rest run last<cr>", desc = "Re-run latest request" },
})

wk.add({
  { "<leader>G", group = "go", icon = "" },
  { "<leader>Gd", "<cmd>lua require('dap-go').debug_test()<cr>", desc = "Debug Test" },
  { "<leader>Gi", "<cmd>GoInstallDeps<Cr>", desc = "Install Go Dependencies" },
  { "<leader>Gt", "<cmd>GoMod tidy<cr>", desc = "Tidy" },
  { "<leader>Ga", "<cmd>GoTestAdd<Cr>", desc = "Add Test" },
  { "<leader>GA", "<cmd>GoTestsAll<Cr>", desc = "Add All Tests" },
  { "<leader>Ge", "<cmd>GoTestsExp<Cr>", desc = "Add Exported Tests" },
  { "<leader>Gg", "<cmd>GoGenerate<Cr>", desc = "Go Generate" },
  { "<leader>GG", "<cmd>GoGenerate %<Cr>", desc = "Go Generate File" },
  { "<leader>Gc", "<cmd>GoCmt<Cr>", desc = "Generate Comment" },
  { "<leader>GI", "<cmd>GoImpl<Cr>", desc = "Implements Interface" },
})

-- select window
wk.add({ { "<leader>ws", "<Cmd>lua require('nvim-window').pick()<CR>", desc = "select window" } })

-- select buffer
wk.add({
  {
    { "<leader>bs", "<Cmd>:BufferLinePick<CR>", desc = "Pick Buffer" },
  },
})

-- scissor manage snippts
wk.add({
  { "<leader>p", group = "snippts" },
  { "<leader>pa", ":ScissorsAddNewSnippet<cr>", desc = "Add New Snippt" },
  { "<leader>pA", ":'<,'>ScissorsAddNewSnippet<cr>", desc = "Add New Snippt in Visual Mode" },
  { "<leader>pe", ":ScissorsEditSnippet<cr>", desc = "Edit Snippt" },
})
