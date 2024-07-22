return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      presets = {
        -- enable border
        lsp_doc_border = true,
      },
      routes = {
        {
          filter = {
            event = "msg_showmode",
            any = {
            -- { find = "%d+L, %d+B" },
            -- { find = "; after #%d+" },
            -- { find = "; before #%d+" },
            },
          },
          view = "notify",
        },
      },
    },
  },
}
