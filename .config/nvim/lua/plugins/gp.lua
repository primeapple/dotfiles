return {
    'robitx/gp.nvim',
    cond = require('toni.utils').is_workstation,
    event = 'VeryLazy',
    -- keys = {
    --     { 'gac', '<cmd>GpChatNew <CR>', { mode = { 'n', 'x' } } },
    --     { 'gaC', '<cmd>GpChatNew vsplit <CR>', { mode = { 'n', 'x' } } },
    --     { 'gap', '<cmd>GpChatPaste <CR>', { mode = { 'n', 'x' } } },
    --     { 'gaP', '<cmd>GpChatPaste vsplit <CR>', { mode = { 'n', 'x' } } },
    -- },
    config = function()
        require('gp').setup({
            -- providers = {
            --     anthropic = {
            --         endpoint = 'https://api.anthropic.com/v1/messages',
            --         secret = os.getenv('ANTHROPIC_API_KEY'),
            --         disable = false,
            --     },
            -- },
        })
        local function keymapOptions(desc)
            return {
                noremap = true,
                silent = true,
                nowait = true,
                desc = 'GPT prompt ' .. desc,
            }
        end

        -- Chat commands
        vim.keymap.set('n', 'gac', '<cmd>GpChatNew<cr>', keymapOptions('New Chat'))
        vim.keymap.set('n', 'gaC', '<cmd>GpChatNew vsplit<cr>', keymapOptions('New Chat vsplit'))
        vim.keymap.set('n', 'gaa', '<cmd>GpChatToggle<cr>', keymapOptions('Toggle Chat'))
        vim.keymap.set('n', 'gaA', '<cmd>GpChatToggle popup<cr>', keymapOptions('Toggle Chat'))
        vim.keymap.set('n', 'gaf', '<cmd>GpChatFinder<cr>', keymapOptions('Chat Finder'))

        vim.keymap.set('v', 'gac', ":<C-u>'<,'>GpChatNew<cr>", keymapOptions('Visual Chat New'))
        vim.keymap.set('v', 'gaC', ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions('Visual Chat New split'))
        vim.keymap.set('v', 'gaa', ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions('Visual Toggle Chat'))
        vim.keymap.set('v', 'gaA', ":<C-u>'<,'>GpChatToggle popup<cr>", keymapOptions('Visual Toggle Chat'))
        vim.keymap.set('v', 'gap', ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions('Visual Chat Paste'))
    end,
}
