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
                    'bash',
                    'css',
                    'dockerfile',
                    'elm',
                    'fish',
                    'html',
                    'java',
                    'javascript',
                    'json',
                    'lua',
                    'markdown',
                    'nix',
                    'python',
                    'regex',
                    'ruby',
                    'rust',
                    'scss',
                    'svelte',
                    'tsx',
                    'typescript',
                    'vim',
                    'yaml',
                },
                highlight = {
                    enable = true,
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    additional_vim_regex_highlighting = false,
                },
                -- EXPERIMENTAL
                indent = {
                    enable = true
                }
            })
        end
    }
    use {
        'nvim-treesitter/nvim-treesitter-context'
    }
    use {
        'hrsh7th/cmp-nvim-lsp'
    }
    use {
        'neovim/nvim-lspconfig',
        requires = 'williamboman/nvim-lsp-installer',
        config = function()
            require('nvim-lsp-installer').setup({
                automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
                ui = {
                    icons = {
                        server_installed = "✓",
                        server_pending = "➜",
                        server_uninstalled = "✗"
                    }
                }
            })

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

            local servers = {
                'bashls',
                'dockerls',
                -- 'eslint',
                -- check sqls, it seems to be a better alternative
                -- 'sqlls',
                'tsserver',
            }
            local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
            for _, lsp in pairs(servers) do
                require('lspconfig')[lsp].setup {
                    on_attach = on_attach,
                    capabilities = capabilities
                }
            end

            -- lua lang server config
            require('lspconfig').sumneko_lua.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { 'vim' },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file('', true),
                        },
                    },
                },
            }
        end
    }
    use {
        'rafamadriz/friendly-snippets',
        event = 'InsertEnter',
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
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
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
        after = 'LuaSnip',
    }
    use {
        'hrsh7th/cmp-nvim-lua',
        after = 'cmp_luasnip',
    }
    use {
        'hrsh7th/cmp-buffer',
        after = 'cmp-nvim-lua',
    }
    use {
        'hrsh7th/cmp-path',
        after = 'cmp-buffer',
    }
    -- use {
    -- TODO is this even needed?
    --     'onsails/lspkind-nvim',
    -- }
    --use {
    -- TODO is this even needed?
    --    ray-x/lsp_signature.nvim
    -- }

    -------------------- EDITING --------------------
    use {
        'tpope/vim-repeat',
        keys = { '.' }
    }
    use {
        'tpope/vim-surround',
        -- lazy loading with 'cs' made problems before, keep an eye on this
        keys = { { 'n', 'ys' }, { 'n', 'ds' }, { 'n', 'cs' }, { 'v', 'S' } }
    }
    use {
        'tpope/vim-unimpaired',
        keys = { '[', ']' }
    }
    use {
        'chaoren/vim-wordmotion',
        config = function() vim.g.wordmotion_prefix = '<leader>' end
    }
    use {
        'Pocco81/AutoSave.nvim',
        config = function()
            require('autosave').setup({
                on_off_commands = true
            })
        end
    }
    use {
        'numToStr/Comment.nvim',
        keys = { 'gc', 'gb' },
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
        'ThePrimeagen/harpoon',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('harpoon').setup({
                -- set branch specific marks
                mark_branch = true
            })

            local map = require('utils').map
            local function toggle_move()
                if (vim.v.count > 0) then
                    -- this does not work (yet?)
                    -- require('harpoon.ui').nav_file(vim.v.count)
                    return '<cmd>lua require("harpoon.ui").nav_file(vim.v.count) <CR>'
                else
                    require('harpoon.mark').toggle_file()
                end
            end
            map('n', 'gh', toggle_move, { expr = true } )
            map('n', ']h', function() require('harpoon.ui').nav_next() end)
            map('n', '[h', function() require('harpoon.ui').nav_prev() end)
            map('n', 'gH', function() require('harpoon.ui').toggle_quick_menu() end)
        end
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
                    path_display = { shorten = { len = 3, exclude = {1, -2, -1} } }
                }
            })
            require('telescope').load_extension('zf-native')

            local map = require('utils').map
            -- basic mappings
            map('n', '<leader>fb', '<cmd> :Telescope buffers <CR>')
            map('n', '<leader>ff', '<cmd> :Telescope find_files <CR>')
            map('n', '<leader>fa', '<cmd> :Telescope find_files follow=true no_ignore=true hidden=true <CR>')
            map('n', '<leader>fh', '<cmd> :Telescope help_tags <CR>')
            map('n', '<leader>fw', '<cmd> :Telescope live_grep <CR>')
            map('n', '<leader>fo', function() require('telescope.builtin').oldfiles({only_cwd=true}) end)
            -- git mappings
            -- map('n', '<leader>fc', '<cmd> :Telescope git_commits <CR>')
            map('n', '<leader>fg', '<cmd> :Telescope git_status <CR>')
        end
    }
    use {
        -- TODO learn me
        'justinmk/vim-dirvish',
    }
    -- use {
    --     -- this could be an alternative to vim-dirvish, see https://github.com/justinmk/vim-dirvish/issues/213
    --     'tamago324/lir.nvim',
    --     requires = {
    --         'nvim-lua/plenary.nvim',
    --         'kyazdani42/nvim-web-devicons'
    --     }
    -- }
    --
    -------------------- INTEGRATION --------------------
    -- use {
    -- TODO learn me
    -- 'tpope/vim-fugitive'
    -- }
    use {
        -- TODO learn me
        'tpope/vim-eunuch'
    }
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({
                signs = {
                    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
                    change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
                    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
                    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
                    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
                },
                numhl = true,
                yadm = {
                    enable = true
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, {expr=true})

                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, {expr=true})

                    -- suggested actions
                    map({'n', 'v'}, '<leader>gs', ':Gitsigns stage_hunk<CR>')
                    map({'n', 'v'}, '<leader>gr', ':Gitsigns reset_hunk<CR>')
                    map('n', '<leader>gS', gs.stage_buffer)
                    map('n', '<leader>gu', gs.undo_stage_hunk)
                    map('n', '<leader>gR', gs.reset_buffer)
                    map('n', '<leader>gp', gs.preview_hunk)
                    map('n', '<leader>gb', function() gs.blame_line{full=true} end)
                    map('n', '<leader>gd', gs.diffthis)
                    map('n', '<leader>gD', function() gs.diffthis('~') end)
                    -- map('n', '<leader>td', gs.toggle_deleted)
                end
            })
        end
    }

    -------------------- APPEARANCE --------------------
    use {
        'luukvbaal/stabilize.nvim',
        config = function() require('stabilize').setup() end
    }
    use {
        'karb94/neoscroll.nvim',
        keys = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
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
            -- show the '~' characters after the end of buffers
            vim.g.dracula_show_end_of_buffer = true
            vim.cmd('colorscheme dracula')
        end
    }

    -------------------- MISC --------------------
    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        ft = { 'markdown' }
    }


    -------------------- FINALIZE --------------------
    -- setup config after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
end)


