return {
  {
    "edluffy/hologram.nvim",
    ft = "image",
    config = function()
      require("hologram").setup({ auto_display = true })
    end,
  },
}
