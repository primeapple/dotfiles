local M = {}

M.options = {
    user = function()
        vim.opt.relativenumber = true
        vim.opt.shiftwidth = 4
        vim.opt.tabstop = 4
        vim.opt.softtabstop = 4
        vim.opt.scrolloff = 5
    end,
}

M.plugins = {
    user = require("custom.plugins"),
    options = {
        lspconfig = {
            setup_lspconf = "custom.plugins.lspconfig",
        },
    },
    override = {
        ["nvim-treesitter/nvim-treesitter"] = require("custom.plugins.treesitter"),
        ["hrsh7th/nvim-cmp"] = require("custom.plugins.cmp"),
        ["nvim-telescope/telescope.nvim"] = require("custom.plugins.telescope"),
        ["kyazdani42/nvim-tree.lua"] = require("custom.plugins.nvimtree"),
    },
    remove = {
        "akinsho/bufferline.nvim",
    }
}

-- M.mappings = {
--     terminal = {
--         -- get out of terminal mode
--         esc_termmode = { "jk" },
--         -- get out of terminal mode and hide it
--         esc_hide_termmode = { "JK" },
--         -- show & recover hidden terminal buffers in a telescope picker
--         pick_term = "<leader>W",
--         -- spawn a single terminal and toggle it
--         -- this just works like toggleterm kinda
--         new_horizontal = "<leader>t-",
--         new_vertical = "<leader>t/",
--         new_float = "<leader>tf",
--         -- unsure about this, do I really need it?
--         spawn_horizontal = "<leader>ts-",
--         spawn_vertical = "<leader>ts/",
--         spawn_window = "<leader>tsw",
--     },
--     misc = {
--         -- can be done via vim unimpaired: yon
--         lineNR_toggle = nil,
--         -- can be done via vim unimpaired: yor
--         lineNR_rel_toggle = nil,
--         new_buffer = "<leader>B",
--         new_tab = nil,
--     },
--     plugins = {
--         lspconfig = {
--             code_action = "<leader>aa",
--             rename = "<leader>ar",
--             formatting = "<leader>=",
--
--         },
--     },
-- }

M.ui = {
    theme = "chadracula",
}

return M

