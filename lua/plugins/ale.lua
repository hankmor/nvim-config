local M = {}

function M.config()
    local ok, _ = pcall(require, "dense-analysis/ale")
    if not ok then
        return
    end
    require("dense-analysis/ale").setup()
end

return M
