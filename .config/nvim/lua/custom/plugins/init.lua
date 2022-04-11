-- TODO: this loads all plugins after going into insert mode
-- better way would be to load them after needed command
-- see https://github.com/wbthomason/packer.nvim#specifying-plugins
local lazy = function(plugin)
    return function()
        require("core.utils").packer_lazy_load(plugin)
    end
end

return {
    -- remove this after master thesis
    {
        "lervag/vimtex",
        ft = { "tex", "bib" },
        setup = lazy("vimtex")
    },
    {
        "Mofiqul/dracula.nvim"
    },
    -- try dracula.nvim
    -- {
    --     "dracula/vim"
    -- },
    {
        "tpope/vim-unimpaired",
        setup = lazy("vim-unimpaired")
    },
    {
        "tpope/vim-surround",
        setup = lazy("vim-surround")
    },
    {
        "chaoren/vim-wordmotion",
        setup = lazy("vim-wordmotion")
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
        config = function() require("neoscroll").setup() end,
        setup = lazy("neoscroll.nvim")
    },
    {
        "ThePrimeagen/harpoon",
        requires = "nvim-lua/plenary.nvim",
        setup = lazy("harpoon")
    },
    {
        "Pocco81/AutoSave.nvim",
        config = function()
            local autosave = require "autosave"
            autosave.setup {
                conditions = {
                    filetype_is_not = { "tex", "log" },
                    exists = true,


                }
            }
        end
    },
    {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        cmd = 'MarkdownPreview'
    }
}
