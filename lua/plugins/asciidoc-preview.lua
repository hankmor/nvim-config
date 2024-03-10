local M = {}

function M.config()
    local ok, _ = pcall(require, "asciidoc-preview")
    if not ok then
        return
    end
    require('asciidoc-preview').setup({
        -- Add user configuration here
        -- Server options
        server = {
            -- Determines how the AsciiDoc file is converted to HTML for the preview.
            -- `js`  - Asciidoctor.js (no local installation needed)
            -- `cmd` - Asciidoctor command (local installation needed)
            converter = 'js',
        },
        -- Preview options
        preview = {
            -- Determines the scroll position of the preview website.
            -- `current` - Keep current scroll position
            -- `start`   - Start of the website
            -- `sync`    - (experimental) Same (similar) position as in Neovim
            --             => inaccurate, because very content dependent
            position = 'current',
        },

        vim.keymap.set("n", "<leader>av", ":AsciiDocPreview<cr>", opts),
    })
end

return M
