-- 在第一行，优先加载
require("plugins.plugins").config()

require("core.opt").config()
require("core.keymaps").config()

-- 启用插件
require("plugins.lualine").config()
require("plugins.nvim-tree").config()
require("plugins.treesitter").config()
require("plugins.mason").config()
require("plugins.mason-lsp").config()
require("plugins.lua-snip").config()
require("plugins.cmp").config()
require("plugins.lsp").config()
require("plugins.gopher").config()
require("plugins.comment").config()
require("plugins.autopairs").config()
require("plugins.bufferline").config()
require("plugins.gitsigns").config()
require("plugins.telescope").config()
require("plugins.markdown").config()
require("plugins.git").config()
require("plugins.dashboard").config()
require("plugins.nvim-lastplace").config()
require("plugins.hop").config()
require("plugins.aerial").config()
require("plugins.project").config()
require("plugins.asciidoc-preview").config()
require("plugins.mux-navigator").config()
require("plugins.ale").config()
require("plugins.vim-go").config()
require("plugins.scissor").config()
-- require("plugins.vimspector").config() require("plugins.neodev").config() require("plugins.nvim-dap").config() require("plugins.nvim-dap-ui").config() require("plugins.nvim-window").config()
require("plugins.lsp-signature").config()
require("plugins.lspkind").config()
-- require("plugins.nvim-window-picker").config()
require("plugins.trouble").config()
