return {
    ----------------------------
    ---- overridden plugins ----
    ----------------------------
    ["kyazdani42/nvim-tree.lua"] = {
        setup = function()
            local map = nvchad.map
            map("n", "<C-n>", "<cmd> :NvimTreeToggle <CR>")
            map("n", "<leader>T", "<cmd> :NvimTreeFocus <CR>")
        end,
    },

    ["nvim-telescope/telescope.nvim"] = {
        setup = function()
            -- require("core.mappings").telescope()

            -- basic mappings
            -- nvchad.map("n", "<leader>fb", "<cmd> :Telescope buffers <CR>")
            -- nvchad.map("n", "<leader>ff", "<cmd> :Telescope find_files <CR>")
            -- nvchad.map("n", "<leader>fa", "<cmd> :Telescope find_files follow=true no_ignore=true hidden=true <CR>")
            -- nvchad.map("n", "<leader>fh", "<cmd> :Telescope help_tags <CR>")
            -- nvchad.map("n", "<leader>fw", "<cmd> :Telescope live_grep <CR>")
            -- nvchad.map("n", "<leader>fo", function() require("telescope.builtin").oldfiles({only_cwd=true}) end)
            -- nvchad.map("n", "<leader>ft", "<cmd> :Telescope themes <CR>")
            -- nvchad.map("n", "<leader>fk", "<cmd> :Telescope keymaps <CR>")
            --
            -- -- git mappings
            -- nvchad.map("n", "<leader>gc", "<cmd> :Telescope git_commits <CR>")
            -- nvchad.map("n", "<leader>gs", "<cmd> :Telescope git_status <CR>")
            --
            -- misc mappings
        end,
    },


    ---------------------
    ---- own plugins ----
    ---------------------

    ["dracula/vim"] = {
        -- vim.cmd[[colorscheme dracula]]
    },
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
    },
    ["jbyuki/venn.nvim"] = {
        cmd = "VBox",
        config = function()
            local function toggle_venn()
                local venn_enabled = vim.inspect(vim.b.venn_enabled)
                if venn_enabled == "nil" then
                    vim.b.venn_enabled = true
                    vim.cmd[[setlocal ve=all]]
                    -- draw a line on HJKL keystokes
                    vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
                    vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
                    vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
                    vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
                    -- draw a box by pressing "f" with visual selection
                    vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
                else
                    vim.cmd[[setlocal ve=]]
                    vim.cmd[[mapclear <buffer>]]
                    vim.b.venn_enabled = nil
                end
            end
            -- toggle keymappings for venn using <leader>v
            nvchad.map("n", "<leader>v", toggle_venn, { noremap = true})
        end,
    },

    ------------------------
    --- just for testing ---
    ------------------------
    ["nvim-treesitter/playground"] = { },
    ["Mofiqul/dracula.nvim"] = { },

}
