local with_pre_save = require('toni.utils').with_pre_save
local is_workstation = require('toni.utils').is_workstation

return {
    'nvim-telescope/telescope.nvim',
    version = '>=0.1.0',
    cmd = 'Telescope',
    keys = {
        -- basic mappings
        { '<leader>F', '<cmd>Telescope resume <CR>' },
        { '<leader>fb', '<cmd>Telescope buffers <CR>' },
        { '<leader>ff', '<cmd>Telescope find_files <CR>' },
        { '<leader>fa', '<cmd>Telescope find_files follow=true no_ignore=true hidden=true <CR>' },
        { '<leader>fh', '<cmd>Telescope help_tags <CR>' },
        { '<leader>fm', '<cmd>Telescope keymaps <CR>' },
        { '<leader>fw', '<cmd>Telescope live_grep <CR>' },
        { '<leader>fW', '<cmd>Telescope grep_string <CR>' },
        {
            '<leader>fo',
            function()
                require('telescope.builtin').oldfiles({ only_cwd = true })
            end,
        },
        { '<leader>fq', '<cmd>Telescope quickfix <CR>' },
        { '<leader>fQ', '<cmd>Telescope quickfixhistory <CR>' },
        {
            '<leader>fl',
            function()
                require('telescope').extensions.live_grep_args.live_grep_args()
            end,
        },
        {
            '<leader>fu',
            with_pre_save(function()
                require('telescope').extensions.undo.undo()
            end),
        },

        -- git mappings
        -- { '<leader>fc', '<cmd>Telescope git_commits <CR>' },
        {
            '<leader>fg',
            with_pre_save(function()
                require('telescope.builtin').git_status()
            end),
        },

        -- dap mappings
        { '<leader>fd', '<cmd>Telescope dap <CR>' },
        -- there is also:
        -- :Telescope dap commands
        -- :Telescope dap configurations
        -- :Telescope dap list_breakpoints
        -- :Telescope dap variables
        -- :Telescope dap frames

        -- lsp mappings
        { 'gd', '<cmd>Telescope lsp_definitions <CR>' },
        { 'gr', '<cmd>Telescope lsp_references <CR>' },

        -- additional RG mappings
        { '<leader>ft', '<cmd>TodoTelescope <CR>' },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'natecraddock/telescope-zf-native.nvim',
        'nvim-telescope/telescope-dap.nvim',
        'nvim-telescope/telescope-live-grep-args.nvim',
        'debugloop/telescope-undo.nvim',
    },
    config = function()
        local telescope = require('telescope')
        local lga_actions = require('telescope-live-grep-args.actions')

        local telescopeConfig = require('telescope.config')
        local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
        -- I want to search in hidden/dot files.
        table.insert(vimgrep_arguments, '--hidden')
        -- I don't want to search in the `.git` directory.
        table.insert(vimgrep_arguments, '--glob')
        table.insert(vimgrep_arguments, '!**/.git/*')

        telescope.setup({
            defaults = {
                -- TODO try this one after update
                -- path_display = { "filename_first" },
                path_display = { shorten = { len = 3, exclude = { 1, -2, -1 } } },
                mappings = {
                    i = {
                        ['<C-d>'] = 'results_scrolling_down',
                        ['<C-u>'] = 'results_scrolling_up',
                        ['<C-f>'] = 'preview_scrolling_down',
                        ['<C-b>'] = 'preview_scrolling_up',
                        ['<C-->'] = 'select_horizontal',
                        ['<C-/>'] = 'select_vertical',
                    },
                    n = {
                        ['<C-d>'] = 'results_scrolling_down',
                        ['<C-u>'] = 'results_scrolling_up',
                        ['<C-f>'] = 'preview_scrolling_down',
                        ['<C-b>'] = 'preview_scrolling_up',
                        ['<C-->'] = 'select_horizontal',
                        ['<C-/>'] = 'select_vertical',
                    },
                },
                vimgrep_arguments = vimgrep_arguments,
            },
            pickers = {
                find_files = {
                    -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                    find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
                },
            },
            extensions = {
                live_grep_args = {
                    auto_quoting = true, -- enable/disable auto-quoting
                    mappings = {
                        i = {
                            ['<C-k>'] = lga_actions.quote_prompt(),
                            ['<C-i>'] = lga_actions.quote_prompt({ postfix = ' --iglob ' }),
                        },
                    },
                },
            },
        })

        telescope.load_extension('zf-native')
        telescope.load_extension('live_grep_args')
        telescope.load_extension('undo')
        if is_workstation() then
            telescope.load_extension('dap')
        end
    end,
}
