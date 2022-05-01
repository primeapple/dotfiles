local lazy = function(plugin)
    return function()
        require("core.utils").packer_lazy_load(plugin)
    end
end

return {
    ----------------------------
    ---- overridden plugins ----
    ----------------------------
    ["kyazdani42/nvim-tree.lua"] = {
        setup = function()
            local map = require("core.utils").map
            map("n", "<C-n>", "<cmd> :NvimTreeToggle <CR>")
            map("n", "<leader>T", "<cmd> :NvimTreeFocus <CR>")
        end,
    },

    ["nvim-telescope/telescope.nvim"] = {
        setup = function()
            require("core.mappings").telescope()

            local map = require("core.utils").map

            -- git mappings
            map("n", "<leader>gc", "<cmd> :Telescope git_commits <CR>")
            map("n", "<leader>gs", "<cmd> :Telescope git_status <CR>")

            -- misc mappings
            map("n", "<leader>ft", "<cmd> :Telescope themes <CR>")
        end,
    },


    ---------------------
    ---- own plugins ---- 
    ---------------------

    -- ["Mofiqul/dracula.nvim"] = { },
    -- ["dracula/vim"] = { },
    ["tpope/vim-unimpaired"] = {
        keys = { "[", "]" }
    },
    -- todo: checkout surround.nvim for this
    ["tpope/vim-surround"] = {
        keys = { { "n", "ys" }, { "n", "ds" }, { "v", "S" } }
    },
    ["chaoren/vim-wordmotion"] = {
        config = function() vim.g.wordmotion_prefix = "<leader>" end
    },
    ["christoomey/vim-tmux-navigator"] = { },
    ["luukvbaal/stabilize.nvim"] = {
        config = function() require("stabilize").setup() end
    },
    ["karb94/neoscroll.nvim"] = {
        keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        config = function() require("neoscroll").setup() end
    },
    ["ThePrimeagen/harpoon"] = {
        requires = { "nvim-lua/plenary.nvim" },
        -- lazy loading leads to problems on this one, 21.04.2022
        -- enabling harpoon leads to problems on this one, 01.05.2022
        -- requires = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
        -- keys = { "<leader>h", "<leader>H" },
        -- config = function()
        --    require("telescope").load_extension("harpoon")
        -- end
    },
    ["Pocco81/AutoSave.nvim"] = {
        config = function()
            local autosave = require("autosave")
            autosave.setup {
                conditions = {
                    filetype_is_not = { "tex", "log" },
                }
            }
        end
    },
    ["iamcco/markdown-preview.nvim"] = {
        run = "cd app && yarn install",
        cmd = "MarkdownPreview"
    }
}
