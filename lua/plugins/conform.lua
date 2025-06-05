return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      java = { "google-java-format" },
    },
    formatters = {
      ["google-java-format"] = {
        command = "google-java-format",
        args = {
          "--aosp",
          "--replace", -- 直接修改文件
          "$FILENAME",
        },
        stdin = false, -- google-java-format 不支持 stdin
      },
    },
  },
  vscode = true,
}
