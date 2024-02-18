-- mason安装提示
require("mason").setup({
  ui = {
      icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
      }
  }
})

-- lsp配置，见: https://github.com/williamboman/mason-lspconfig.nvim
require("mason-lspconfig").setup({
  -- 确保安装，没有会自动安装, 服务列表见文档的 available-lsp-servers 部分
  ensure_installed = {
    "lua_ls", "pyright", "gopls", "jsonls", "vuels"
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
local util = require("lspconfig/util")

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = {'lua_ls', 'clangd', 'rust_analyzer', 'pyright', 'tsserver', "jdtls", "jsonls", "vuels"}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end
--
-- 配置 gopls
lspconfig.gopls.setup {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmol" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  single_file_support = true,
  settings = {
    gopls = {
        analyses = {
            unusedparams = true,
        },
        staticcheck = true,
        -- buildFlags = { "-tags=wireinject" },
        --env = { GOFLAGS = "tags=wireinject" },
        -- ui.completion.usePlaceholders = true,
        },
  },
  on_attach = function(client, bufnr)
    -- 禁用格式化功能，交给专门插件插件处理
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    require("keymappings").lspList(bufnr)
    -- 保存时自动格式化
    -- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end
}

function FormatFunction()
  vim.lsp.buf.format({
    async = true,
    range = {
      ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
      ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
    }
  })
end
