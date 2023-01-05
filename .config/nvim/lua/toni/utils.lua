local M = {}

M.map = function(modes, keys, command, opt)
    local options = { silent=true }

    if opt then
        options = vim.tbl_extend("force", options, opt)
    end

    if type(keys) == "table" then
        for _, keymap in ipairs(keys) do
            M.map(modes, keymap, command, opt)
        end
        return
    end

    vim.keymap.set(modes, keys, command, opt)
end

return M
