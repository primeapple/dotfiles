return {
    {
        'rebelot/heirline.nvim',
        event = 'UIEnter',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'rebelot/kanagawa.nvim',
            'lewis6991/gitsigns.nvim',
        },
        config = function()
            local conditions = require('heirline.conditions')
            local utils = require('heirline.utils')
            local setup_colors = function()
                return {
                    fg = utils.get_highlight('Normal').fg,
                    bg = utils.get_highlight('Normal').bg,
                    red = utils.get_highlight('DiagnosticError').fg,
                    dark_red = utils.get_highlight('DiffDelete').bg,
                    green = utils.get_highlight('String').fg,
                    blue = utils.get_highlight('Function').fg,
                    gray = utils.get_highlight('NonText').fg,
                    orange = utils.get_highlight('Constant').fg,
                    purple = utils.get_highlight('Statement').fg,
                    cyan = utils.get_highlight('Special').fg,
                    diag_warn = utils.get_highlight('DiagnosticWarn').fg,
                    diag_error = utils.get_highlight('DiagnosticError').fg,
                    diag_hint = utils.get_highlight('DiagnosticHint').fg,
                    diag_info = utils.get_highlight('DiagnosticInfo').fg,
                    git_del = utils.get_highlight('diffDeleted').fg,
                    git_add = utils.get_highlight('diffAdded').fg,
                    git_change = utils.get_highlight('diffChanged').fg,
                }
            end

            local FileNameBlock = {
                init = function(self)
                    self.filename = vim.api.nvim_buf_get_name(0)
                end,
            }

            local FileIcon = {
                init = function(self)
                    local filename = self.filename
                    local extension = vim.fn.fnamemodify(filename, ':e')
                    self.icon, self.icon_color =
                        require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
                end,
                provider = function(self)
                    return self.icon and (self.icon .. ' ')
                end,
                hl = function(self)
                    return { fg = self.icon_color }
                end,
            }

            local FileName = {
                provider = function(self)
                    local filename = vim.fn.fnamemodify(self.filename, ':t')
                    if filename == '' then
                        return '[No Name]'
                    end
                    return filename
                end,
                hl = { bold = true },
            }

            local FileFlags = {
                {
                    condition = function()
                        return vim.bo.modified
                    end,
                    provider = '● ',
                    hl = { bold = true },
                },
                {
                    condition = function()
                        return not vim.bo.modifiable or vim.bo.readonly
                    end,
                    provider = ' ',
                    hl = { fg = 'orange' },
                },
            }

            FileNameBlock = utils.insert(
                FileNameBlock,
                FileFlags,
                FileIcon,
                FileName,
                { provider = '%<' } -- This means that the statusline is cut here when there's not enough space
            )

            local FileType = {
                provider = function()
                    return string.upper(vim.bo.filetype)
                end,
                hl = { bold = true },
            }

            local Ruler = {
                provider = function()
                    local lines = vim.api.nvim_buf_line_count(0)
                    return string.format('%%%dl:%%2c %%P', #tostring(lines))
                    -- return '%5l:%2c %P',
                end,
                hl = { bold = true },
            }

            local ScrollBar = {
                static = {
                    sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
                },
                provider = function(self)
                    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
                    local lines = vim.api.nvim_buf_line_count(0)
                    return string.rep(self.sbar[8 - math.floor(curr_line / lines * 7)], 2)
                end,
                hl = {
                    bg = 'fg',
                    fg = 'bg',
                    bold = true,
                },
            }

            local LSPActive = {
                condition = conditions.lsp_attached,
                update = { 'LspAttach', 'LspDetach' },
                provider = function()
                    local names = {}
                    for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
                        table.insert(names, server.name)
                    end
                    return ' ' .. table.concat(names, ' ')
                end,
                hl = { fg = 'purple', bold = true },
            }

            local Diagnostics = {
                condition = conditions.has_diagnostics,

                -- Fetching custom diagnostic icons
                static = {
                    error_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.ERROR],
                    warn_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.WARN],
                    info_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.INFO],
                    hint_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.HINT],
                },

                init = function(self)
                    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
                    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
                end,

                update = { 'DiagnosticChanged', 'BufEnter' },

                {
                    provider = function(self)
                        -- 0 is just another output, we can decide to print it or not!
                        return self.errors > 0 and (self.error_icon .. ' ' .. self.errors .. ' ')
                    end,
                    hl = { fg = 'diag_error' },
                },
                {
                    provider = function(self)
                        return self.warnings > 0 and (self.warn_icon .. ' ' .. self.warnings .. ' ')
                    end,
                    hl = { fg = 'diag_warn' },
                },
                {
                    provider = function(self)
                        return self.info > 0 and (self.info_icon .. ' ' .. self.info .. ' ')
                    end,
                    hl = { fg = 'diag_info' },
                },
                {
                    provider = function(self)
                        return self.hints > 0 and (self.hint_icon .. ' ' .. self.hints)
                    end,
                    hl = { fg = 'diag_hint' },
                },
            }

            local Git = {
                condition = conditions.is_git_repo,

                init = function(self)
                    self.status_dict = vim.b.gitsigns_status_dict
                end,

                hl = { fg = 'purple' },

                { -- git branch name
                    provider = function(self)
                        local branch = self.status_dict.head or ''
                        if #branch > 14 then
                            branch = string.sub(branch, 1, 14) .. '…'
                        end
                        return ' ' .. branch .. ' '
                    end,
                    hl = { bold = true },
                },
                {
                    provider = function(self)
                        local count = self.status_dict.added or 0
                        return count > 0 and ('  ' .. count)
                    end,
                    hl = { fg = 'git_add' },
                },
                {
                    provider = function(self)
                        local count = self.status_dict.removed or 0
                        return count > 0 and ('  ' .. count)
                    end,
                    hl = { fg = 'git_del' },
                },
                {
                    provider = function(self)
                        local count = self.status_dict.changed or 0
                        return count > 0 and ('  ' .. count)
                    end,
                    hl = { fg = 'git_change' },
                },
            }
            local Align = { provider = '%=' }
            local Space = { provider = '  ' }

            local DefaultStatuslineLeft = { FileNameBlock, Space, Git, Align }
            local DefaultStatusLineRight = {
                LSPActive,
                Space,
                Diagnostics,
                Space,
                FileType,
                Space,
                Ruler,
                Space,
                ScrollBar,
            }
            local DefaultStatusLine = {
                DefaultStatuslineLeft,
                DefaultStatusLineRight,
                hl = { bg = 'bg' },
            }

            require('heirline').setup({
                opts = {
                    colors = setup_colors(),
                },
                statusline = { DefaultStatusLine },
            })
        end,
    },
    {
        'freddiehaddad/feline.nvim',
        event = 'UIEnter',
        enabled = false,
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
        enabled = false,
        dependencies = { 'rebelot/heirline.nvim' },
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
