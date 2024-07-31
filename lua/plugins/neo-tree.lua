local remove_lsp_cwd = require("util").remove_lsp_cwd

local function is_file(path)
  if path:sub(-1) == "/" then
    return false
  else
    return true
  end
end

local function get_filetype_from_path(path)
  local match = string.match(path, "%.([^%.\\/]*)$")
  if match then
    local ext = string.lower(match)
    if ext == "go" then
      return "go"
    elseif ext == "ts" then
      return "typescript"
    elseif ext == "py" then
      return "python"
    elseif ext == "lua" then
      return "lua"
    elseif ext == "vue" then
      return "vuejs"
    elseif ext == "rs" then
      return "rust"
    elseif ext == "java" then
      return "java"
    else
      return "unknown"
    end
  else
    return "unknown"
  end
end

local function get_parent_dir(path)
  if not path then
    return nil
  end

  local parent_path = path:match("(.+)/")
  if parent_path then
    local name = parent_path:match("([^/]+)$")
    return name
  else
    return "root"
  end
end

local function get_filename_without_extension_from_path(path, client_name)
  local relative_path = remove_lsp_cwd(path, client_name)
  if relative_path == nil then
    return nil
  end
  return get_parent_dir(relative_path)
end

local go_file = function(path)
  local file = io.open(path, "w")
  if file then
    local parent_name = get_filename_without_extension_from_path(path, "gopls")
    if parent_name ~= nil then
      if parent_name == "root" then
        parent_name = "main"
      end
      file:write("package " .. parent_name .. "\n")
    end
    file:close()
  end
end
local rust_file = function(path) end
local python_file = function(path) end
local vuejs_file = function(path) end
local java_file = function(path) end
local lua_file = function(path) end
local unknown_file = function(path) end

local filetype_mapping = {
  go = go_file,
  rust = rust_file,
  python = python_file,
  vuejs = vuejs_file,
  java = java_file,
  lua = lua_file,
  unknown = unknown_file,
}

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git Explorer",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer Explorer",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
      -- because `cwd` is not set up properly.
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("neo-tree")
            end
          end
        end,
      })
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["<space>"] = "none",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
            desc = "Copy Path to Clipboard",
          },
          ["O"] = {
            function(state)
              require("lazy.util").open(state.tree:get_node().path, { system = true })
            end,
            desc = "Open with System Application",
          },
          ["P"] = { "toggle_preview", config = { use_float = false } },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        git_status = {
          symbols = {
            unstaged = "󰄱",
            staged = "󰱒",
          },
        },
      },
    },
    config = function(_, opts)
      local function on_move(data)
        LazyVim.lsp.on_rename(data.source, data.destination)
      end

      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
        {
          event = events.FILE_ADDED,
          handler = function(path)
            print("path:", path)
            if is_file(path) then
              local file_type = get_filetype_from_path(path)
              filetype_mapping[file_type](path)
            end
          end,
        },
      })
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },
}
