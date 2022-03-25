require('packer').startup(function(use)
    -- plugins
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'

    -- programming
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    use 'onsails/lspkind-nvim'
    use { 'lervag/vimtex', ft = { 'tex', 'bib' }}
    use {
      'lewis6991/spellsitter.nvim',
      config = function()
        require('spellsitter').setup()
      end
    }

    -- editing
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-repeat'
    use 'rstacruz/vim-closer'
    use 'chaoren/vim-wordmotion'
    use 'Pocco81/AutoSave.nvim'
    use 'ggandor/lightspeed.nvim'

    -- navigating
    use 'christoomey/vim-tmux-navigator'
    use { "ThePrimeagen/harpoon", requires = "nvim-lua/plenary.nvim" }
    use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- appearance
    use 'chentau/marks.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'kyazdani42/nvim-web-devicons'

    -- colorschemes
    use 'dracula/vim'
    use 'sainnhe/everforest'

    -- additional
    use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview' }
end)


--------------------------
-- Plugin Configuration --
--------------------------
vim.cmd('colorscheme dracula')


vim.g.wordmotion_prefix = '<Leader>'

require('lualine').setup()

