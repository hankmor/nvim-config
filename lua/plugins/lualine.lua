return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      sections = {
        lualine_x = {
          {
            "rest",
            icon = "",
            fg = "#428890",
          },
        },
      },
    },
  },
}
