require('packer').startup(function()
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

    -- editing
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-unimpaired'
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
    use 'machakann/vim-highlightedyank'
    use 'chentau/marks.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'kyazdani42/nvim-web-devicons'

    -- colorschemes
    use 'dracula/vim'
    use 'sainnhe/everforest'
end)


--------------------------
-- Plugin Configuration --
--------------------------
vim.cmd('colorscheme dracula')

require('marks').setup {
    builtin_marks = { ".", "[", "]", "{", "}", "^" }

}

require('nvim-treesitter.configs').setup {
    -- Maybe change to list of languages
    ensure_installed = "maintained",

    highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        additional_vim_regex_highlighting = false,
    },
    -- EXPERIMENTAL
    indent = {
        enable = true
    }
}

require('telescope').load_extension('fzf')

vim.api.nvim_set_keymap('n', "<C-f>", "<cmd>Telescope find_files<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', "<C-/>", "<cmd>Telescope live_grep<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', "<C-e>", "<cmd>Telescope oldfiles<cr>", { noremap = true })

vim.g.wordmotion_prefix = '<Leader>'

require('lualine').setup()

-- LSP
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'elmls', 'tsserver' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities,
    }
end

-- luasnip setup
local luasnip = require('luasnip')

-- nvim-cmp setup
local lspkind = require('lspkind')
local cmp = require('cmp')
cmp.setup {
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
        })
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-j>'] = cmp.mapping.select_prev_item(),
        ['<C-k>'] = cmp.mapping.select_next_item(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-q>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    },
    sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    },
}

require("autosave").setup(
{ conditions = { filetype_is_not = {"tex", "log"} } }
)
