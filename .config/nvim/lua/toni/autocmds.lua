local api = vim.api

--------------------
-- HIGHLIGHT YANK --
--------------------
local highligh_yank_group = api.nvim_create_augroup('highlight_yank', { clear = true })

-- highlight after yanking
api.nvim_create_autocmd('TextYankPost', {
    group = highligh_yank_group,
    command = 'silent! lua vim.highlight.on_yank({timeout=700})',
})

-- restore last position after opening buffer
api.nvim_create_autocmd('BufReadPost', {
    group = highligh_yank_group,
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
})

---------------
-- TEMPLATES --
---------------

-- See https://zignar.net/2024/11/20/template-files-for-nvim/

local templates_group = api.nvim_create_augroup('templates', { clear = true })

-- Helper function to load template
local function load_template(filepath)
    local home = os.getenv('HOME')
    local fname = vim.fn.fnamemodify(filepath, ':t')
    local tmpl = home .. '/.config/nvim/templates/' .. fname .. '.tpl'
    
    if vim.uv.fs_stat(tmpl) then
        vim.cmd('0r ' .. tmpl)
        return true
    else
        local ext = vim.fn.fnamemodify(filepath, ':e')
        tmpl = home .. '/.config/nvim/templates/' .. ext .. '.tpl'
        if vim.uv.fs_stat(tmpl) then
            vim.cmd('0r ' .. tmpl)
            return true
        end
    end
    return false
end

-- Template for new files
api.nvim_create_autocmd('BufNewFile', {
    group = templates_group,
    desc = 'Load template file for new files',
    callback = function(args)
        load_template(args.file)
    end,
})

-- Template for existing but empty files
api.nvim_create_autocmd('BufReadPost', {
    group = templates_group,
    desc = 'Load template file for empty existing files',
    callback = function(args)
        -- Check if buffer is empty (only has one line and that line is empty)
        local lines = api.nvim_buf_get_lines(0, 0, -1, false)
        if #lines == 1 and lines[1] == '' then
            load_template(args.file)
        end
    end,
})
