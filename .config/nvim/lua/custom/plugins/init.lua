-- TODO: this loads plugin after going into insert mode
-- better way would be to load them after needed command or key
-- see https://github.com/wbthomason/packer.nvim#specifying-plugins
local lazy = function(plugin)
    return function()
        require("core.utils").packer_lazy_load(plugin)
    end
end

return {
    -- {
    --     "Mofiqul/dracula.nvim"
    -- },
    -- {
    --     "dracula/vim"
    -- },
    {
        "tpope/vim-unimpaired",
        keys = { "[", "]" }
    },
    -- todo: checkout surround nvim for this
    {
        "tpope/vim-surround",
        keys = { "ys", "cs", "ds", { "v", "S" } }
    },
    {
        "chaoren/vim-wordmotion",
        config = function() vim.g.wordmotion_prefix = "<leader>" end
    },
    { 
        "christoomey/vim-tmux-navigator"
    },
    { 
        "luukvbaal/stabilize.nvim",
        config = function() require("stabilize").setup() end
    },
    {
        "karb94/neoscroll.nvim",
        keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        config = function() require("neoscroll").setup() end
    },
    {
        -- lazy loading leads to problems on this one, 21.04.2022
        "ThePrimeagen/harpoon",
        requires = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
        -- keys = { "<leader>h", "<leader>H" },
        config = function()
           require("telescope").load_extension('harpoon')
        end
    },
    {
        "Pocco81/AutoSave.nvim",
        config = function()
            local autosave = require("autosave")
            autosave.setup {
                conditions = {
                    filetype_is_not = { "tex", "log" },
                    exists = true,
                }
            }
        end
    },
    {
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        cmd = "MarkdownPreview"
    }
}
