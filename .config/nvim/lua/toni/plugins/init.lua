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

    -------------------- TREESITTER --------------------
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = {
            'nvim-treesitter/nvim-treesitter-context',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'RRethy/nvim-treesitter-textsubjects'
        },
        config = function()
            require('toni.plugins.treesitter')
        end
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
                            emoji = '[EMO]',
                            copilot = '[COP]',
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
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    {
                        name = 'buffer',
                        keyword_length = 3,
                        option = {
                            keyword_pattern = [[\k\+]],
                        }
                    },
                    { name = 'nvim_lua' },
                    { name = 'path' },
                    { name = 'calc' },
                    { name = 'emoji' },
                    { name = 'copilot' }
                }),
                experimental = {
                    -- this breaks copilot.lua otherwise
                    ghost_text = false,
                },
                -- suggested by copilot_cmp
                -- sorting = {
                --     priority_weight = 2,
                --     comparators = {
                --         require('copilot_cmp.comparators').prioritize,
                --         -- Below is the default comparitor list and order for nvim-cmp
                --         cmp.config.compare.offset,
                --         -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                --         cmp.config.compare.exact,
                --         cmp.config.compare.score,
                --         cmp.config.compare.recently_used,
                --         cmp.config.compare.locality,
                --         cmp.config.compare.kind,
                --         cmp.config.compare.sort_text,
                --         cmp.config.compare.length,
                --         cmp.config.compare.order,
                --     },
                -- },
            })

            -- only need a subset of the default sources in markdown
            cmp.setup.filetype('markdown', {
                sources = cmp.config.sources({
                    {
                        name = 'buffer',
                        keyword_length = 3,
                        option = {
                            keyword_pattern = [[\k\+]],
                        }
                    },
                    { name = 'path' },
                    { name = 'calc' },
                    { name = 'emoji' },
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
    use {
        'hrsh7th/cmp-calc',
        after = 'cmp-path',
    }
    use {
        'hrsh7th/cmp-emoji',
        after = 'cmp-calc',
    }
    use {
        'zbirenbaum/copilot-cmp',
        after = { 'copilot.lua', 'cmp-calc' },
        config = function ()
            require('copilot_cmp').setup({
                formatters = {
                    insert_text = require('copilot_cmp.format').remove_existing
                },
            })
        end
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
            require('toni.plugins.lsp').setup()
        end
    }
    use {
        -- config in ftplugin/java.lua
        'mfussenegger/nvim-jdtls',
    }

    -------------------- DEBUGGING --------------------
    use {
        'mfussenegger/nvim-dap',
        requires = {
            'theHamsta/nvim-dap-virtual-text',
            'rcarriga/nvim-dap-ui',
        },
        config = function()
            local dap, dapui = require('dap'), require('dapui')

            local map = require('toni.utils').map
            map('n', 'yod', require('dapui').toggle)
            map('n', '[od', require('dapui').open)
            map('n', ']od', require('dapui').close)

            -- starting and ending ui automatically
            dap.listeners.after.event_initialized['dapui_config'] = dapui.open
            dap.listeners.before.event_terminated['dapui_config'] = dapui.close
            dap.listeners.before.event_exited['dapui_config'] = dapui.close
        end
    }
    use {
        'David-Kunz/jester',
        ft = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue' },
        config = function()
            require('jester').setup({
                terminal_cmd = 'ToggleTerm',
                path_to_jest_run = './node_modules/.bin/jest',
                path_to_jest_debug = './node_modules/.bin/jest'
            })
            local map = require('toni.utils').map
            map('n', '<leader>rr', require('jester').run_last)
            map('n', '<leader>rf', require('jester').run_file)
            map('n', '<leader>rn', require('jester').run)
            map('n', '<leader>rR', require('jester').debug_last)
            map('n', '<leader>rF', require('jester').debug_file)
            map('n', '<leader>rN', require('jester').debug)
        end
    }
    -- checkout later, would prefer it over jester
    -- use { 'nvim-neotest/neotest' }
    use {
        'andrewferrier/debugprint.nvim',
        config = function()
            require('debugprint').setup({
                create_keymaps = false,
            })
            local map = require('toni.utils').map
            map('n', 'g??', function() return require('debugprint').debugprint({ variable = true }) end, { expr = true })
            map('n', 'g?', function() return require('debugprint').debugprint({ variable = true, motion = true }) end, { expr = true })
            map('v', 'g?', function() return require('debugprint').debugprint({ variable = true }) end, { expr = true })
        end,
    }

    -------------------- AI --------------------
    use {
        'zbirenbaum/copilot.lua',
        event = 'VimEnter',
        config = function()
            vim.defer_fn(function()
                require('copilot').setup({
                    panel = {
                        enabled = false
                    },
                    suggestion = {
                        enabled = true,
                        auto_trigger = true,
                    },
                    filetypes = {
                        -- disable for files without filetype
                        [''] = false,
                        text = false,
                        -- because we don't want Copilot in `.env` files
                        -- see https://github.com/zbirenbaum/copilot.lua/issues/111
                        sh = function ()
                            if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '%.env$') then
                                -- disable for .env files
                                return false
                            end
                            return true
                        end,
                    }
                })
            end, 100)
        end,
    }

    -------------------- EDITING --------------------
    use {
        'kylechui/nvim-surround',
        keys = { { 'n', 'gz' }, { 'n', 'gZ' }, { 'v', 'gz' }, { 'v', 'gZ' } },
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
    }
    use {
        'tpope/vim-unimpaired',
        keys = { '[', ']' }
    }
    use {
        'Pocco81/auto-save.nvim',
        config = function()
            require('auto-save').setup({
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
    use {
        'ckolkey/ts-node-action',
        requires = { 'nvim-treesitter' },
        config = function()
            local ts_node_action = require('ts-node-action')
            ts_node_action.setup()
            local map = require('toni.utils').map
            map('n', '<leader><leader>', ts_node_action.node_action, { desc = 'Trigger Node Action' })
        end
    }

    -------------------- NAVIGATION --------------------
    use {
        'ThePrimeagen/harpoon',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('harpoon').setup({
                global_settings = {
                    -- set branch specific marks
                    mark_branch = true
                }
            })

            local map = require('toni.utils').map
            local function toggle_move()
                if (vim.v.count > 0) then
                    -- this does not work (yet?)
                    -- require('harpoon.ui').nav_file(vim.v.count)
                    return '<cmd>lua require("harpoon.ui").nav_file(vim.v.count) <CR>'
                else
                    require('harpoon.mark').toggle_file()
                end
            end
            map('n', 'gh', toggle_move, { expr = true })
            map('n', ']h', require('harpoon.ui').nav_next)
            map('n', '[h', require('harpoon.ui').nav_prev)
            map('n', 'gH', require('harpoon.ui').toggle_quick_menu)
        end
    }
    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        after = 'nvim-dap',
        requires = {
            'nvim-lua/plenary.nvim',
            'natecraddock/telescope-zf-native.nvim',
            'nvim-telescope/telescope-dap.nvim'
        },
        config = function()
            require('toni.plugins.telescope')
        end
    }
    use {
        'tamago324/lir.nvim',
        requires = { 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons', 'tamago324/lir-git-status.nvim' },
        config = function()
            local map = require('toni.utils').map
            map('n', '-', [[<Cmd>execute 'e ' .. expand('%:p:h')<CR>]])

            local actions = require('lir.actions')
            local clipboard_actions = require('lir.clipboard.actions')
            local mark_actions = require('lir.mark.actions')

            require('lir').setup({
                show_hidden_files = true,
                devicons = {
                    enable = true,
                },
                float = { winblend = 0 }, -- keep float setting even if you don't use it, otherwise it will crash
                hide_cursor = false,

                mappings = {
                    ['<CR>'] = actions.edit,
                    ['<C-->'] = actions.split,
                    ['<C-/>'] = actions.vsplit,
                    ['q']    = actions.quit,
                    ['-']    = actions.up,

                    ['M']    = actions.mkdir,
                    ['T']    = actions.touch,
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
            local map = require('toni.utils').map
            map('n', 'gp', '<Nop>')
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
        'stefandtw/quickfix-reflector.vim',
        ft = { 'qf' },
        config = function()
            -- " Remove all entries from directory/file under cursor
            -- function GetDir(path)
            --     let depth = len(split(a:path, '/', 1))
            --     let current_depth = len(split(trim(a:path[:getpos('.')[2] - 1], '/', 2), '/', 1))
            --     return escape(fnamemodify(a:path, repeat(':h', depth - current_depth)), '/')
            -- endfunction
            -- nnoremap <leader>l<bs> <cmd>exe 'g/^' . GetDir(bufname(getloclist(0)[line('.') - 1]['bufnr'])) . '/d'<bar>w<cr>
            -- nnoremap <leader>q<bs> <cmd>exe 'g/^' . GetDir(bufname(getqflist()[line('.') - 1]['bufnr'])) . '/d'<bar>w<cr>
        end
    }
    use {
        'knubie/vim-kitty-navigator',
        run = 'cp ./*.py ~/.config/kitty/',
        config = function()
            vim.g.kitty_navigator_no_mappings = 1
            local map = require('toni.utils').map
            -- moving around splits with <C-hjkl>
            -- Terminal mode:
            map('t', '<C-h>', '<C-\\><C-n>:KittyNavigateLeft<CR>')
            map('t', '<C-j>', '<C-\\><C-n>:KittyNavigateDown<CR>')
            map('t', '<C-k>', '<C-\\><C-n>:KittyNavigateUp<CR>')
            map('t', '<C-l>', '<C-\\><C-n>:KittyNavigateRight<CR>')
            -- Insert mode:
            map('i', '<C-h>', '<Esc>:KittyNavigateLeft<CR>')
            map('i', '<C-j>', '<Esc>:KittyNavigateDown<CR>')
            map('i', '<C-k>', '<Esc>:KittyNavigateUp<CR>')
            map('i', '<C-l>', '<Esc>:KittyNavigateRight<CR>')
            -- Visual mode:
            map('v', '<C-h>', '<Esc>:KittyNavigateLeft<CR>')
            map('v', '<C-j>', '<Esc>:KittyNavigateDown<CR>')
            map('v', '<C-k>', '<Esc>:KittyNavigateUp<CR>')
            map('v', '<C-l>', '<Esc>:KittyNavigateRight<CR>')
            -- Normal mode:
            map('n', '<C-h>', '<cmd>KittyNavigateLeft<CR>')
            map('n', '<C-j>', '<cmd>KittyNavigateDown<CR>')
            map('n', '<C-k>', '<cmd>KittyNavigateUp<CR>')
            map('n', '<C-l>', '<cmd>KittyNavigateRight<CR>')
        end
    }


    -------------------- MOVEMENTS --------------------
    use {
        'chaoren/vim-wordmotion',
        config = function() vim.g.wordmotion_prefix = '<leader>' end
    }
    use {
        'ggandor/leap.nvim',
        config = function ()
            -- TODO: S doesn't work, maybe use s/S for operator mode as well
            -- s/S for normal, visual mode
            -- z/Z, x/X for operator mode
            -- require('leap').set_default_keymaps()
            local map = require('toni.utils').map
            map({'n', 'o', 'v'}, 's', '<Plug>(leap-forward-to)')
            map({'n', 'o', 'v'}, 'S', '<Plug>(leap-backward-to)')
            -- map({'o', 'v'}, 'x', '<Plug>(leap-forward-till)')
            -- map({'o', 'v'}, 'X', '<Plug>(leap-backward-till)')
            map({'n', 'o', 'v'}, 'gx', '<Plug>(leap-cross-window)')
        end
    }
    use {
        'bronson/vim-visual-star-search',
        keys = { { 'v', '*'} }
    }

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
                    end, { expr = true })

                    map('n', '[g', function()
                        if vim.wo.diff then return '[g' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true })

                    -- suggested actions
                    map({'n', 'v'}, '<leader>ga', ':Gitsigns stage_hunk<CR>')
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
        config = function()
            -- use the following for centering after C-d/C-u, but doesn't look so nice
            -- https://www.reddit.com/r/neovim/comments/zjeplx/centering_after_cd_with_neoscroll/
            require('neoscroll').setup()
        end
    }
    use {
        'gbprod/stay-in-place.nvim',
        config = function() require('stay-in-place').setup() end
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
                -- options = { theme = 'dracula-nvim' }
                options = { theme = 'catppuccin' }
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
        'catppuccin/nvim',
        as = 'catppuccin',
        config = function()
            vim.g.catppuccin_flavour = 'mocha' -- latte, frappe, macchiato, mocha
            require('catppuccin').setup({
                show_end_of_buffer = true
            })
            vim.api.nvim_command 'colorscheme catppuccin'
        end
    }

    -------------------- Languages/Tools --------------------
    use {
        'lervag/vimtex',
        ft = { 'tex' }
    }

    -------------------- MISC --------------------
    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        ft = { 'markdown' }
    }
    use {
        'akinsho/toggleterm.nvim',
        tag = 'v2.*',
        config = function()
            require('toggleterm').setup({
                size = function(term)
                    if term.direction == 'horizontal' then
                        return 15
                    elseif term.direction == 'vertical' then
                        return vim.o.columns * 0.3
                    end
                end,
                open_mapping = '<C-t>',
                direction = 'vertical'
            })
        end
    }
    use {
        'ja-ford/delaytrain.nvim',
        config = function()
            require('delaytrain').setup({
                grace_period = 5
            })
        end
    }

    use {
        'tamton-aquib/duck.nvim',
        config = function()
            require('toni.plugins.duck')
        end
    }

    -------------------- FINALIZE --------------------
    -- setup config after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
end)


