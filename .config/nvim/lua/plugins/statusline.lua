return {
    {
        'rebelot/heirline.nvim',
        event = 'UIEnter',
        enabled = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'rebelot/kanagawa.nvim',
            'lewis6991/gitsigns.nvim',
        },
        config = function()
            local conditions = require('heirline.conditions')
            local utils = require('heirline.utils')
            local colors = require('kanagawa.colors').setup()

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
                    -- first, trim the pattern relative to the current directory. For other
                    -- options, see :h filename-modifers
                    local filename = vim.fn.fnamemodify(self.filename, ':.')
                    if filename == '' then
                        return '[No Name]'
                    end
                    -- now, if the filename would occupy more than 1/4th of the available
                    -- space, we trim the file path to its initials
                    if not conditions.width_percent_below(#filename, 0.25) then
                        filename = vim.fn.pathshorten(filename)
                    end
                    return filename
                end,
                hl = { fg = utils.get_highlight('Directory').fg },
            }

            local FileFlags = {
                {
                    condition = function()
                        return vim.bo.modified
                    end,
                    provider = '[+]',
                    -- TODO white
                    hl = { fg = 'green' },
                },
                {
                    condition = function()
                        return not vim.bo.modifiable or vim.bo.readonly
                    end,
                    provider = '',
                    -- TODO white
                    hl = { fg = 'orange' },
                },
            }

            -- Now, let's say that we want the filename color to change if the buffer is
            -- modified. Of course, we could do that directly using the FileName.hl field,
            -- but we'll see how easy it is to alter existing components using a "modifier"
            -- component

            local FileNameModifer = {
                hl = function()
                    if vim.bo.modified then
                        -- use `force` because we need to override the child's hl foreground
                        return { fg = 'cyan', bold = true, force = true }
                    end
                end,
            }

            -- let's add the children to our FileNameBlock component
            FileNameBlock = utils.insert(
                FileNameBlock,
                FileIcon,
                utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
                FileFlags,
                { provider = '%<' } -- this means that the statusline is cut here when there's not enough space
            )

            local FileType = {
                provider = function()
                    return string.upper(vim.bo.filetype)
                end,
                hl = { fg = utils.get_highlight('Type').fg, bold = true },
            }

            local Ruler = {
                -- %l = current line number
                -- %L = number of lines in the buffer
                -- %c = column number
                -- %P = percentage through file of displayed window
                -- provider = "%7(%l/%3L%):%2c %P",
                provider = '%7(%l):%2c %P',
            }

            local ScrollBar = {
                static = {
                    -- TODO use better icons, start from top to bottom
                    sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
                },
                provider = function(self)
                    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
                    local lines = vim.api.nvim_buf_line_count(0)
                    local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
                    return string.rep(self.sbar[i], 2)
                end,
                hl = { fg = 'blue', bg = 'bright_bg' },
            }

            local LSPActive = {
                condition = conditions.lsp_attached,
                update = { 'LspAttach', 'LspDetach' },
                provider = function()
                    local names = {}
                    for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
                        table.insert(names, server.name)
                    end
                    return ' [' .. table.concat(names, ' ') .. ']'
                end,
                hl = { fg = 'green', bold = true },
            }

            local Diagnostics = {

                condition = conditions.has_diagnostics,

                static = {
                    error_icon = vim.fn.sign_getdefined('DiagnosticSignError')[1].text,
                    warn_icon = vim.fn.sign_getdefined('DiagnosticSignWarn')[1].text,
                    info_icon = vim.fn.sign_getdefined('DiagnosticSignInfo')[1].text,
                    hint_icon = vim.fn.sign_getdefined('DiagnosticSignHint')[1].text,
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
                        return self.errors > 0 and (self.error_icon .. self.errors .. ' ')
                    end,
                    hl = { fg = 'diag_error' },
                },
                {
                    provider = function(self)
                        return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ')
                    end,
                    hl = { fg = 'diag_warn' },
                },
                {
                    provider = function(self)
                        return self.info > 0 and (self.info_icon .. self.info .. ' ')
                    end,
                    hl = { fg = 'diag_info' },
                },
                {
                    provider = function(self)
                        return self.hints > 0 and (self.hint_icon .. self.hints)
                    end,
                    hl = { fg = 'diag_hint' },
                },
            }

            local Git = {
                condition = conditions.is_git_repo,

                init = function(self)
                    self.status_dict = vim.b.gitsigns_status_dict
                end,

                hl = { fg = 'orange' },

                { -- git branch name
                    provider = function(self)
                        local branch = self.status_dict.head or ''
                        if #branch > 14 then
                            branch = string.sub(branch, 1, 14) .. '…'
                        end
                        return ' ' .. branch
                    end,
                    hl = { bold = true },
                },
                -- TODO use icons
                {
                    provider = function(self)
                        local count = self.status_dict.added or 0
                        return count > 0 and ('+' .. count)
                    end,
                    hl = { fg = 'git_add' },
                },
                {
                    provider = function(self)
                        local count = self.status_dict.removed or 0
                        return count > 0 and ('-' .. count)
                    end,
                    hl = { fg = 'git_del' },
                },
                {
                    provider = function(self)
                        local count = self.status_dict.changed or 0
                        return count > 0 and ('~' .. count)
                    end,
                    hl = { fg = 'git_change' },
                },
            }
            local Align = { provider = '%=' }
            local Space = { provider = ' ' }

            local DefaultStatuslineLeft = { FileNameBlock, Git, Align }
            local DefaultStatusLineRight = { LSPActive, Diagnostics, FileType, Ruler, ScrollBar }
            local DefaultStatusLine = { DefaultStatuslineLeft, DefaultStatusLineRight }

            require('heirline').setup({
                opts = {
                    colors = colors,
                },
                statusline = { DefaultStatusLine },
            })
        end,
    },
    {
        'freddiehaddad/feline.nvim',
        event = 'UIEnter',
        -- enabled = false,
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
