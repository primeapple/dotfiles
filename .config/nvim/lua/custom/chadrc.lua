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
        nvimtree = {
            lazy_load = false,
        },
    },
    default_plugin_config_replace = {
        nvim_treesitter = treesitterConfig,
        nvim_cmp = cmpConfig,
        nvim_tree = {
            --  the commented stuff is to make nvim-tree more like netrw
            view = {
                width = 35,
                -- mappings = {
                --     list = {
                --         { key = "<CR>", action = "edit_in_place" }
                --     }
                -- }
            },
            -- open_on_setup = true,
            -- ignore_buffer_on_setup = true,
            -- actions = {
            --     change_dir = {
            --         enable = false,
            --     }
            -- }
        }
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
        new_horizontal = "<leader>t-",
        new_vertical = "<leader>t/",
        new_float = "<leader>tf",
        -- unsure about this, do I really need it?
        spawn_horizontal = "<leader>ts-",
        spawn_vertical = "<leader>ts/",
        spawn_window = "<leader>tsw",
    },
    misc = {
        -- can be done via vim unimpaired: yon
        lineNR_toggle = nil,
        -- can be done via vim unimpaired: yor
        lineNR_rel_toggle = nil,
        new_buffer = "<leader>B",
        new_tab = nil,
    },
    plugins = {
        lspconfig = {
            code_action = "<leader>aa",
            rename = "<leader>ar",
            formatting = "<leader>=",
        },
        nvimtree = {
            focus = "<leader>T",
        },
        telescope = {
            git_commits = "<leader>fgc",
            git_status = "<leader>fgs",
            help = "<leader>fgs",
            themes = "<leader>ft",
        },
    },
}

M.ui = {
    theme = "chadracula",
}

return M

