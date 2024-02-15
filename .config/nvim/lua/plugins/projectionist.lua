return {
    {
        enabled = false,
        'tpope/vim-projectionist',
        event = 'VeryLazy',
        -- keys = { 'gp', 'gP' },
        config = function()
            local map = require('toni.utils').map
            map('n', 'gp', '<Nop>')
            map('n', 'gP', '<cmd>:A<CR>')
            local alphabet = {
                'a',
                'b',
                'c',
                'd',
                'e',
                'f',
                'g',
                'h',
                'i',
                'j',
                'k',
                'l',
                'm',
                'n',
                'o',
                'p',
                'q',
                'r',
                's',
                't',
                'u',
                'v',
                'w',
                'x',
                'y',
                'z',
            }
            -- gp${lowerLetter} opens projection in current window
            for _, letter in ipairs(alphabet) do
                map('n', 'gp' .. letter, '<cmd>:E' .. letter .. '<CR>')
            end
            -- gp${upperLetter} opens projection in vertical split
            for _, letter in ipairs(alphabet) do
                map('n', 'gp' .. string.upper(letter), '<cmd>:V' .. letter .. '<CR>')
            end
        end,
    },
}
