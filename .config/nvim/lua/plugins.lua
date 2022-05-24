-- bootstrapping packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
    -- plugins
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'

    -- programming
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    "bash",
                    "css",
                    "dockerfile",
                    "elm",
                    "fish",
                    "html",
                    "java",
                    "javascript",
                    "json",
                    "lua",
                    "markdown",
                    "nix",
                    "python",
                    "regex",
                    "ruby",
                    "rust",
                    "scss",
                    "svelte",
                    "tsx",
                    "typescript",
                    "vim",
                    "yaml",
                }
            }
        end
    }
    -- use 'neovim/nvim-lspconfig'
    -- use 'hrsh7th/nvim-cmp'
    -- use 'hrsh7th/cmp-nvim-lsp'
    -- use 'saadparwaiz1/cmp_luasnip'
    -- use 'L3MON4D3/LuaSnip'
    -- use 'onsails/lspkind-nvim'

    -- editing
    -- use 'tpope/vim-fugitive'
    -- use 'tpope/vim-repeat'
    use {
        'tpope/vim-surround',
        keys = { { "n", "ys" }, { "n", "ds" }, { "v", "S" } }
    }
    use { 
        'tpope/vim-unimpaired',
        keys = { "[", "]" }
    }
    use {
        'chaoren/vim-wordmotion',
        config = function() vim.g.wordmotion_prefix = "<leader>" end
    }
    use 'Pocco81/AutoSave.nvim'
    use {
        'numToStr/Comment.nvim',
        keys = { "gc", "gb" },
        config = function() require('Comment').setup() end
    }

    -- use 'ggandor/lightspeed.nvim'


    -- navigating
    use 'christoomey/vim-tmux-navigator'
    use {
        "ThePrimeagen/harpoon",
        requires = "nvim-lua/plenary.nvim"
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'natecraddock/telescope-zf-native.nvim'
        },
        config = function()
            require('telescope').setup{
                defaults = {
                    path_display = { shorten = { len = 3, exclude = {1, -1} } }
                }
            }
            require('telescope').load_extension('zf-native')
            local map = require("utils").map
            -- basic mappings
            map("n", "<leader>fb", "<cmd> :Telescope buffers <CR>")
            map("n", "<leader>ff", "<cmd> :Telescope find_files <CR>")
            map("n", "<leader>fa", "<cmd> :Telescope find_files follow=true no_ignore=true hidden=true <CR>")
            map("n", "<leader>fh", "<cmd> :Telescope help_tags <CR>")
            map("n", "<leader>fw", "<cmd> :Telescope live_grep <CR>")
            map("n", "<leader>fo", function() require("telescope.builtin").oldfiles({only_cwd=true}) end)
            map("n", "<leader>ft", "<cmd> :Telescope themes <CR>")
            -- git mappings
            map("n", "<leader>gc", "<cmd> :Telescope git_commits <CR>")
            map("n", "<leader>gs", "<cmd> :Telescope git_status <CR>")
        end
    }

    -- appearance
    -- use 'chentau/marks.nvim'
    -- use 'kyazdani42/nvim-web-devicons'
    use {
        'luukvbaal/stabilize.nvim',
        config = function() require("stabilize").setup() end
    }
    use {
        "karb94/neoscroll.nvim",
        keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        config = function() require("neoscroll").setup() end
    }

    -- colorschemes
    use {
        'Mofiqul/dracula.nvim',
        config = function()
            vim.cmd('colorscheme dracula')
            -- show the '~' characters after the end of buffers
            vim.g.dracula_show_end_of_buffer = true
            -- use transparent background
            vim.g.dracula_transparent_bg = true
        end
    }

    -- additional
    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        cmd = 'MarkdownPreview'
    }


    -- setup config after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
end)


