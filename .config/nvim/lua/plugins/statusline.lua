return {
    {
        'rebelot/heirline.nvim',
        event = 'UIEnter',
        dependencies = {
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

            local Align = { provider = '%=' }
            local Space = { provider = '  ' }

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

            local SearchCount = {
                condition = function()
                    return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
                end,
                init = function(self)
                    local ok, search = pcall(vim.fn.searchcount)
                    if ok and search.total then
                        self.search = search
                    end
                end,
                provider = function(self)
                    local search = self.search
                    return string.format('  [%d/%d]', search.current, math.min(search.total, search.maxcount))
                end,
                hl = { bold = true },
            }

            local MacroRec = {
                condition = function()
                    return vim.fn.reg_recording() ~= '' and vim.o.cmdheight == 0
                end,
                provider = '   ',
                hl = { fg = 'orange', bold = true },
                utils.surround({ '[', ']' }, nil, {
                    provider = function()
                        return vim.fn.reg_recording()
                    end,
                    hl = { fg = 'fg', bold = true },
                }),
                update = {
                    'RecordingEnter',
                    'RecordingLeave',
                },
            }

            local DefaultStatuslineLeft = { FileNameBlock, SearchCount, MacroRec, Space, Git, Align }
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
        'vimpostor/vim-tpipeline',
        cond = require('toni.utils').is_workstation,
        event = 'UIEnter',
        dependencies = { 'rebelot/heirline.nvim' },
        init = function()
            vim.cmd('let g:tpipeline_size = &co')
            vim.g.tpipeline_clearstl = 1
            vim.g.tpipeline_refreshcmd = 'kitty @ set-tab-title ""'
            vim.api.nvim_create_autocmd('User', {
                pattern = 'TpipelineSize',
                command = 'let g:tpipeline_size = &co',
            })
        end,
    },
}
