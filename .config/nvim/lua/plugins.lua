-- bootstrapping packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
    -------------------- PLUGIN MANAGEMENT --------------------
    use {
        'wbthomason/packer.nvim'
    }
    use {
        'lewis6991/impatient.nvim'
    }

    -------------------- PROGRAMMING --------------------
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
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
            })
        end
    }
    use {
        'neovim/nvim-lspconfig',
        after = 'cmp_nvim_lsp',
        config = function()
            local opts = { noremap=true, silent=true }
            vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
            vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
            vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
            vim.api.nvim_set_keymap('n', '<leader>D', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(client, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ac', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>aa', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
            end

            -- Use a loop to conveniently call 'setup' on multiple servers and
            -- map buffer local keybindings when the language server attaches
            local servers = {
                -- "bashls",
                -- "dockerls",
                -- "eslint",
                -- special install script needed
                -- "sumneko_lua",
                -- check sqls, it seems to be a better alternative
                -- "sqlls",
                "tsserver",
            }
            local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
            for _, lsp in pairs(servers) do
                require('lspconfig')[lsp].setup {
                    on_attach = on_attach,
                    capabilities = capabilities
                }
            end
        end
    }
    use {
        'rafamadriz/friendly-snippets',
        event = "InsertEnter",
    }
    use {
        'hrsh7th/nvim-cmp',
        after = 'friendly-snippets',
        config = function()
            local cmp = require'cmp'

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer', keyword_length = 5 },
                    { name = 'nvim_lua' },
                    { name = 'path' }
                })
            })
        end
    }
    use {
        'L3MON4D3/LuaSnip',
        wants = 'friendly-snippets',
        after = 'nvim-cmp',
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
        end
    }
    use {
        'saadparwaiz1/cmp_luasnip',
        after = "LuaSnip",
    }
    use {
        'hrsh7th/cmp-nvim-lua',
        after = "cmp_luasnip",
    }
    use {
        'hrsh7th/cmp-nvim-lsp',
        after = "cmp-nvim-lua",
    }
    use {
        'hrsh7th/cmp-buffer',
        after = 'cmp-nvim-lsp',
    }
    use {
        'hrsh7th/cmp-path',
        after = "cmp-buffer",
    }
    -- use {
    -- TODO is this even needed?
    --     'onsails/lspkind-nvim',
    -- }

    -------------------- EDITING --------------------
    use {
        'tpope/vim-repeat'
    }
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
    use {
        'Pocco81/AutoSave.nvim',
        config = function() require('autosave') end
    }
    use {
        'numToStr/Comment.nvim',
        keys = { "gc", "gb" },
        config = function() require('Comment').setup() end
    }
    use {
        -- TODO learn me
        'andymass/vim-matchup'
    }
    use {
        -- TODO learn me
        'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup() end
    }
    -- use {
    -- TODO learn me
    -- 'ggandor/lightspeed.nvim'
    -- }


    -------------------- NAVIGATION --------------------
    use {
        'christoomey/vim-tmux-navigator'
    }
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
            require('telescope').setup({
                defaults = {
                    path_display = { shorten = { len = 3, exclude = {1, -1} } }
                }
            })
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

    -------------------- INTEGRATION --------------------
    -- use {
    -- TODO learn me
    -- 'tpope/vim-fugitive'
    -- }
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    } 

    -------------------- APPEARANCE --------------------
    use {
        'chentau/marks.nvim',
        keys = { 'm' },
        config = function() require('marks').setup() end
    }
    use {
        'luukvbaal/stabilize.nvim',
        config = function() require('stabilize').setup() end
    }
    use {
        'karb94/neoscroll.nvim',
        keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        config = function() require('neoscroll').setup() end
    }
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function() require('indent_blankline').setup() end
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup({
                options = { theme = 'dracula-nvim' }
            })
        end
    }

    -------------------- COLORSCHEMES --------------------
    use {
        'Mofiqul/dracula.nvim',
        config = function()
            vim.cmd('colorscheme dracula')
            -- show the '~' characters after the end of buffers
            vim.g.dracula_show_end_of_buffer = true
        end
    }

    -------------------- MISC --------------------
    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        cmd = 'MarkdownPreview'
    }


    -------------------- FINALIZE --------------------
    -- setup config after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
end)


