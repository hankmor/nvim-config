vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod", "gowork", "gotmpl" },
  callback = function()
    -- set go specific options
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    -- vim.opt_local.colorcolumn = "120"
  end,
})

return {
  {
    "olexsmir/gopher.nvim",
    event = "VeryLazy",
    ft = "go",
    config = function() end,
  },
}
