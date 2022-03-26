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
M.plugins = {
    install = userPlugins,
    options = {
        lspconfig = {
            setup_lspconf = "custom.plugins.lspconfig",
        },
    },
    default_plugin_config_replace = {
        nvim_treesitter = treesitterConfig
    }
}

M.mappings = {
    misc = {
        lineNR_toggle = "<Leader>tn", -- toggle line number
        lineNR_rel_toggle = "<Leader>tr",
        new_buffer = "<Leader>B",
        new_tab = nil,
    },
    plugins = {
        lspconfig = {
            code_action = "<Leader>aa",
            rename = "<Leader>ar",
            formatting = "<Leader>=",
        }
    },
    nvimtree = {
        toggle = "<C-t>",
        focus = nil,
    },
    telescope = {
        git_commits = "<Leader>fgc",
        git_status = "<Leader>fgs",
        themes = "<Leader>ft",
    }
}

M.ui = {
    theme = "chadracula",
}

return M

