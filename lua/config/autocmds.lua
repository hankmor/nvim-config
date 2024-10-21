-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- vim.api.nvim_set_hl(0, "Comment", { fg = "#828bb8", underline = false, bold = false })
-- vim.api.nvim_set_hl(0, "Comment", { fg = "#7ca1f2", underline = false, bold = false })

-- already enabled in lazyvim
-- local _border = "rounded"
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--   border = _border,
-- })
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
--   border = _border,
-- })
-- vim.diagnostic.config({
--   float = { border = _border },
-- })
