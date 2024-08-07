return {
    {
        'freddiehaddad/feline.nvim',
        event = 'UIEnter',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'rebelot/kanagawa.nvim',
            'lewis6991/gitsigns.nvim',
        },
        config = function()
            local colors = function()
                local theme = require('kanagawa.colors').setup({ theme = 'wave' }).theme
                return {
                    bg = theme.ui.bg,
                    bg_dim = theme.ui.bg_dim,
                    fg = theme.ui.fg,
                    fg_dim = theme.ui.fg_dim,
                    fg_reverse = theme.ui.fg_reverse,
                    special = theme.ui.special,
                    diag_warn = theme.diag.warning,
                    diag_error = theme.diag.error,
                    diag_hint = theme.diag.hint,
                    diag_info = theme.diag.info,
                    git_del = theme.vcs.removed,
                    git_add = theme.vcs.added,
                    git_change = theme.vcs.changed,
                }
            end

            local c = {
                fileinfo = {
                    provider = {
                        name = 'file_info',
                        opts = {
                            -- type = 'relative-short',
                            type = 'base-only',
                        },
                    },
                    hl = {
                        style = 'bold',
                    },
                    right_sep = 'block',
                },
                gitBranch = {
                    provider = 'shortened_git_branch',
                    left_sep = 'block',
                    right_sep = 'block',
                    hl = {
                        fg = 'special',
                    },
                },
                gitDiffAdded = {
                    provider = 'git_diff_added',
                    hl = {
                        fg = 'git_add',
                    },
                },
                gitDiffRemoved = {
                    provider = 'git_diff_removed',
                    hl = {
                        fg = 'git_del',
                    },
                },
                gitDiffChanged = {
                    provider = 'git_diff_changed',
                    hl = {
                        fg = 'git_change',
                    },
                },
                diagnostic_errors = {
                    provider = 'diagnostic_errors',
                    hl = {
                        fg = 'diag_error',
                    },
                },
                diagnostic_warnings = {
                    provider = 'diagnostic_warnings',
                    hl = {
                        fg = 'diag_warn',
                    },
                },
                diagnostic_hints = {
                    provider = 'diagnostic_hints',
                    hl = {
                        fg = 'diag_hint',
                    },
                },
                diagnostic_info = {
                    provider = 'diagnostic_info',
                    hl = {
                        fg = 'diag_info',
                    },
                },
                lsp_client_names = {
                    provider = 'lsp_client_names',
                    hl = {
                        style = 'bold',
                        fg = 'special',
                    },
                    left_sep = 'left_filled',
                    right_sep = 'block',
                },
                file_type = {
                    provider = {
                        name = 'file_type',
                        opts = {
                            filetype_icon = false,
                            case = 'uppercase',
                        },
                    },
                    hl = {
                        style = 'bold',
                        fg = 'fg',
                    },
                    left_sep = 'block',
                    right_sep = 'block',
                },
                position = {
                    provider = 'position',
                    hl = {
                        fg = 'fg',
                        style = 'bold',
                    },
                    left_sep = 'block',
                    right_sep = 'block',
                },
                line_percentage = {
                    provider = 'line_percentage',
                    hl = {
                        style = 'bold',
                    },
                    left_sep = 'block',
                    right_sep = 'block',
                },
                scroll_bar = {
                    provider = {
                        name = 'scroll_bar',
                        opts = {
                            reverse = true,
                        },
                    },
                    hl = {
                        bg = 'fg',
                        fg = 'bg',
                        style = 'bold',
                    },
                },
            }

            local left = {
                c.fileinfo,
                c.gitBranch,
                c.gitDiffAdded,
                c.gitDiffRemoved,
                c.gitDiffChanged,
            }

            local right = {
                c.lsp_client_names,
                c.diagnostic_errors,
                c.diagnostic_warnings,
                c.diagnostic_info,
                c.diagnostic_hints,
                c.file_type,
                c.position,
                c.line_percentage,
                c.scroll_bar,
            }

            local components = {
                active = {
                    left,
                    right,
                },
                inactive = {
                    left,
                    right,
                },
            }

            require('feline').setup({
                components = components,
                theme = colors(),
                custom_providers = {
                    shortened_git_branch = function()
                        ---@diagnostic disable-next-line: undefined-field
                        local branch = vim.b.gitsigns_head or ''
                        if #branch > 14 then
                            branch = string.sub(branch, 1, 14) .. '…'
                        end
                        return branch, ' '
                    end,
                },
            })
        end,
    },
    {
        'vimpostor/vim-tpipeline',
        -- TODO: works for now, but may be better with a check if the current terminal is kitty
        cond = require('toni.utils').is_workstation,
        event = 'UIEnter',
        dependencies = { 'freddiehaddad/feline.nvim' },
        init = function()
            vim.cmd('let g:tpipeline_size = &co')
            vim.g.tpipeline_clearstl = 1
            vim.g.tpipeline_refreshcmd = 'kitty @ set-tab-title refresh_tabbar'
            vim.api.nvim_create_autocmd('User', {
                pattern = 'TpipelineSize',
                command = 'let g:tpipeline_size = &co',
            })
        end,
    },
}
