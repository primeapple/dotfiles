 -- have a look at `~/.config/nvim/lua/core/default_config.lua`
local M = {}

M.options = {
    relativenumber = true,
    shiftwidth = 4,
    tabstop = 4,
    softtabstop = 4,
    splitbelow = true,
    splitright = true,
    scrollof = 10,
}

local userPlugins = require("custom.plugins")
local treesitterConfig = require("custom.plugins.treesitter")
local cmpConfig = require("custom.plugins.cmp")
M.plugins = {
    install = userPlugins,
    options = {
        lspconfig = {
            setup_lspconf = "custom.plugins.lspconfig",
        },
    },
    default_plugin_config_replace = {
        nvim_treesitter = treesitterConfig,
        nvim_cmp = cmpConfig,
    },
    default_plugin_remove = {
        "akinsho/bufferline.nvim",
    }
}

M.mappings = {
    terminal = {
        -- get out of terminal mode
        esc_termmode = { "jk" },
        -- get out of terminal mode and hide it
        esc_hide_termmode = { "JK" },
        -- show & recover hidden terminal buffers in a telescope picker
        pick_term = "<leader>W",
        -- spawn a single terminal and toggle it
        -- this just works like toggleterm kinda
        new_horizontal = "<Leader>t-",
        new_vertical = "<Leader>t/",
        new_float = "<Leader>tf",
        -- unsure about this, do I really need it?
        spawn_horizontal = "<Leader>ts-",
        spawn_vertical = "<Leader>ts/",
        spawn_window = "<leader>tsw",
    },
    misc = {
        -- can be done via vim unimpaired: yon
        lineNR_toggle = nil,
        -- can be done via vim unimpaired: yor
        lineNR_rel_toggle = nil,
        new_buffer = "<Leader>B",
        new_tab = nil,
    },
    plugins = {
        lspconfig = {
            code_action = "<Leader>aa",
            rename = "<Leader>ar",
            formatting = "<Leader>=",
        },
        nvimtree = {
            toggle = "<Leader>tt",
            focus = nil,
        },
        telescope = {
            git_commits = "<Leader>fgc",
            git_status = "<Leader>fgs",
            themes = "<Leader>ft",
        },
    },
}

M.ui = {
    theme = "chadracula",
}

return M

