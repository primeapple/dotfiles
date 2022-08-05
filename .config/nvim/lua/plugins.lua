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
                    'fish',
                    'html',
                    'java',
                    'javascript',
                    'json',
                    'lua',
                    'markdown',
                    'markdown_inline',
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

    -------------------- CMP --------------------
    use {
        'hrsh7th/cmp-nvim-lsp'
    }
    use {
        'rafamadriz/friendly-snippets',
        event = 'InsertEnter',
    }
    use {
        'hrsh7th/nvim-cmp',
        after = 'friendly-snippets',
        requires = 'onsails/lspkind-nvim',
        config = function()
            local cmp = require('cmp')
            local lspkind = require('lspkind')
            cmp.setup({
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol_text',
                        menu = {
                            buffer = '[BUF]',
                            nvim_lua = '[API]',
                            nvim_lsp = '[LSP]',
                            path = '[PATH]',
                            luasnip = '[SNIP]',
                            calc = '[CALC]',
                            emoji = '[EMO]'
                        }
                    })
                },
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
                    { name = 'buffer', keyword_length = 3 },
                    { name = 'nvim_lua' },
                    { name = 'path' },
                    { name = 'calc' },
                    { name = 'emoji' }
                }),
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
    use {
        'hrsh7th/cmp-calc',
        after = 'cmp-path',
    }
    use {
        'hrsh7th/cmp-emoji',
        after = 'cmp-calc',
    }
    -- use {
    --     -- this needs some further config check the repo pls
    --     'rcarriga/cmp-dap',
    --     after = 'cmp-emoji'
    -- }

    -------------------- LSP --------------------
    use {
        'neovim/nvim-lspconfig',
        requires = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', 'ray-x/lsp_signature.nvim' },
        config = function()
            require('config.lsp').setup()
        end
    }
    use {
        -- config in ftplugin/java.lua
        'mfussenegger/nvim-jdtls',
    }

    -------------------- DEBUGGING --------------------
    use {
        'mfussenegger/nvim-dap'
    }
    use {
        'David-Kunz/jester',
        ft = { 'javascript', 'typescript' },
        config = function()
            require('jester').setup({
                path_to_jest_run = './node_modules/.bin/jest',
                path_to_jest_debug = './node_modules/.bin/jest'
            })
            local map = require('utils').map
            map('n', '<leader>r', function() require('jester').run_last() end)
            map('n', '<leader>R', function() require('jester').run() end)
            map('n', '<leader>d', function() require('jester').debug_last() end)
            map('n', '<leader>D', function() require('jester').debug() end)
        end
    }
    -- checkout later
    -- use { 'nvim-neotest/neotest' }

    -------------------- EDITING --------------------
    use {
        'kylechui/nvim-surround',
        keys = { { 'n', 'ys' }, { 'n', 'ds' }, { 'n', 'cs' }, { 'v', 'S' } },
        config = function()
            require('nvim-surround').setup({})
        end
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
        'Pocco81/auto-save.nvim',
        config = function()
            require('autosave').setup({
                debounce_delay = 5000
                -- on_off_commands = true
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
        branch = '0.1.x',
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
        'tamago324/lir.nvim',
        requires = { 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons', 'tamago324/lir-git-status.nvim' },
        config = function()
            local map = require('utils').map
            map( 'n', '-', [[<Cmd>execute 'e ' .. expand('%:p:h')<CR>]])

            local actions = require('lir.actions')
            local clipboard_actions = require('lir.clipboard.actions')
            local mark_actions = require('lir.mark.actions')

            require('lir').setup({
                show_hidden_files = true,
                devicons_enable = true,
                float = { winblend = 0 }, -- keep float setting even if you don't use it, otherwise it will crash
                hide_cursor = false,

                mappings = {
                    ['<CR>'] = actions.edit,
                    ['q']    = actions.quit,
                    ['-']    = actions.up,

                    ['M']    = actions.mkdir,
                    ['T']    = actions.newfile,
                    ['R']    = actions.rename,
                    ['Y']    = actions.yank_path,
                    ['.']    = actions.toggle_show_hidden,
                    ['D']    = actions.delete,

                    ['C']    = clipboard_actions.copy,
                    ['X']    = clipboard_actions.cut,
                    ['P']    = clipboard_actions.paste,

                    ['m']    = mark_actions.toggle_mark,
                }
            })

            require('lir.git_status').setup({})
        end
    }
    use {
        'tpope/vim-projectionist',
        config = function ()
            local map = require('utils').map
            map('n', 'gP', '<cmd>:A<CR>')
            local alphabet = { 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z' }
            -- gp${lowerLetter} opens projection in current window
            for _, letter in ipairs(alphabet) do
                map('n', 'gp' .. letter, '<cmd>:E' .. letter .. '<CR>')
            end
            -- gp${upperLetter} opens projection in vertical split
            for _, letter in ipairs(alphabet) do
                map('n', 'gp' .. string.upper(letter), '<cmd>:V' .. letter .. '<CR>')
            end
        end
    }
    use {
        'romainl/vim-qf'
    }

    --
    -------------------- INTEGRATION --------------------
    -- use {
    -- TODO learn me
    -- 'tpope/vim-fugitive'
    -- }
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
                    map('n', ']g', function()
                        if vim.wo.diff then return ']g' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, {expr=true})

                    map('n', '[g', function()
                        if vim.wo.diff then return '[g' end
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
    use {
        'tpope/vim-dispatch'
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
    use {
        'j-hui/fidget.nvim',
        config = function ()
            require('fidget').setup({})
        end
    }
    use {
        'stevearc/dressing.nvim',
        config = function ()
            require('dressing').setup({
                input = {
                    insert_only = false,
                    start_in_insert = false,
                }
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


