return {
    -------------------- EDITING --------------------
    -- TODO replace with mini
    {
        'kylechui/nvim-surround',
        keys = { 'gz', 'gZ' },
        config = function()
            require('nvim-surround').setup({
                aliases = {
                    ['b'] = { ')', ']', '}' }
                },
                keymaps = {
                    -- insert = '<C-g>z',
                    -- insert_line = 'gC-ggZ',
                    normal = 'gz',
                    normal_cur = 'gZ',
                    normal_line = 'gzgz',
                    normal_cur_line = 'gZgZ',
                    visual = 'gz',
                    visual_lin = 'gZ',
                    delete = 'gzd',
                    change = 'gzc',
                }
            })
        end
    },
    {
        'tpope/vim-unimpaired',
        keys = { '[', ']' }
    },
    -- TODO replace with mini
    {
        'numToStr/Comment.nvim',
        keys = {
            { 'gc', mode={ 'n', 'v' } },
            { 'gb', mode={ 'n', 'v' } },
        },
        config = function() require('Comment').setup() end
    },
    {
        'andymass/vim-matchup',
        event = 'VeryLazy',
        init = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = 'VeryLazy',
        opts = {
            disable_in_macro = true,
        }
    },


    -------------------- NAVIGATION --------------------
    {
        'knubie/vim-kitty-navigator',
        build = 'cp ./*.py ~/.config/kitty/',
        keys = {
            -- Terminal mode:
            { '<C-h>', '<C-\\><C-n>:KittyNavigateLeft<CR>', mode = 't' },
            { '<C-j>', '<C-\\><C-n>:KittyNavigateDown<CR>', mode = 't' },
            { '<C-k>', '<C-\\><C-n>:KittyNavigateUp<CR>', mode = 't' },
            { '<C-l>', '<C-\\><C-n>:KittyNavigateRight<CR>', mode = 't' },
            -- Insert mode:
            { '<C-h>', '<Esc>:KittyNavigateLeft<CR>', mode = 'i' },
            { '<C-j>', '<Esc>:KittyNavigateDown<CR>', mode = 'i' },
            { '<C-k>', '<Esc>:KittyNavigateUp<CR>', mode = 'i' },
            { '<C-l>', '<Esc>:KittyNavigateRight<CR>', mode = 'i' },
            -- Visual mode:
            { '<C-h>', '<Esc>:KittyNavigateLeft<CR>', mode = 'v' },
            { '<C-j>', '<Esc>:KittyNavigateDown<CR>', mode = 'v' },
            { '<C-k>', '<Esc>:KittyNavigateUp<CR>', mode = 'v' },
            { '<C-l>', '<Esc>:KittyNavigateRight<CR>', mode = 'v' },
            -- Normal mode:
            { '<C-h>', '<cmd>KittyNavigateLeft<CR>', mode = 'n' },
            { '<C-j>', '<cmd>KittyNavigateDown<CR>', mode = 'n' },
            { '<C-k>', '<cmd>KittyNavigateUp<CR>', mode = 'n' },
            { '<C-l>', '<cmd>KittyNavigateRight<CR>', mode = 'n' },
        },
        init = function()
            vim.g.kitty_navigator_no_mappings = 1
        end
    },

    -------------------- TEXT OBJECTS --------------------
    {
        'chaoren/vim-wordmotion',
        keys = {
            { '<leader>w', mode = { 'n', 'o', 'x' } },
            { '<leader>b', mode = { 'n', 'o', 'x' } },
            { '<leader>e', mode = { 'n', 'o', 'x' } },
            { '<leader>ge', mode = { 'n', 'o', 'x' } },
            { '<leader>aw', mode = { 'o', 'x' } },
            { '<leader>iw', mode = { 'o', 'x' } },
        },
        init = function()
            vim.g.wordmotion_prefix = '<leader>'
        end
    },
    {
        'chrisgrieser/nvim-various-textobjs',
        keys = {
            { 'gG', mode = { 'o', 'v' } },
            { 'ii', mode = { 'o', 'v' } },
            { 'ik', mode = { 'o', 'v' } },
            { 'iv', mode = { 'o', 'v' } },
            { 'R', mode = { 'o', 'v' } },
        },
        opts = {
            useDefaultKeymaps = true,
        }
    },

    -------------------- MOVEMENTS --------------------
    {
        'ggandor/leap.nvim',
        keys = {
            { 's', '<Plug>(leap-forward-to)', mode = { 'n', 'o', 'v' } },
            { 'S', '<Plug>(leap-backward-to)', mode = { 'n', 'o', 'v' } },
            { 'gs', '<Plug>(leap-cross-window)', mode = { 'n', 'o', 'v' } },
        }
    },
    {
        'bronson/vim-visual-star-search',
        keys = { { '*', mode = 'v' } }
    },

    -------------------- APPEARANCE --------------------
    -- TODO replace with `set splitkeep=screen`, when using nvim 0.9
    {
        'luukvbaal/stabilize.nvim',
        event = 'VeryLazy',
        config = true
    },
    {
        'karb94/neoscroll.nvim',
        keys = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        config = true
    },
    {
        -- TODO try if it works with config = true
        'gbprod/stay-in-place.nvim',
        keys = { '=', '<', '>' },
        config = true
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        event = { "BufReadPost", "BufNewFile" },
        config = true
    },
    {
        'j-hui/fidget.nvim',
        event = 'VeryLazy',
        config = true
    },
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        config = {
            input = {
                insert_only = false,
                start_in_insert = false,
            }
        }
    },
    {
        'NvChad/nvim-colorizer.lua',
        event = 'VeryLazy',
        opts = {
            user_default_options = {
                names = false,
                tailwind = 'lsp',
                mode = 'virtualtext',
                sass = {
                    enable = true
                }
            }
        }
    },
    {
        'tzachar/local-highlight.nvim',
        event = 'VeryLazy',
        config = true
    },

    -------------------- Languages/Tools --------------------
    {
        'lervag/vimtex',
        ft = 'tex'
    },

    -------------------- MISC --------------------
    {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        ft = { 'markdown' }
    },
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        keys = { '<C-t>', '<leader>r' },
        opts = {
            size = function(term)
                if term.direction == 'horizontal' then
                    return 15
                elseif term.direction == 'vertical' then
                    return vim.o.columns * 0.3
                end
            end,
            open_mapping = '<C-t>',
            direction = 'vertical'
        }
    },
    {
        'ja-ford/delaytrain.nvim',
        event = 'VeryLazy',
        opts = {
            grace_period = 5
        }
    },
    {
        'okuuva/auto-save.nvim',
        event = 'VeryLazy',
        opts = {
            debounce_delay = 2000
        }
    }
}
