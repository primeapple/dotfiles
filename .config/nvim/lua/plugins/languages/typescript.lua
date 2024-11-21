local is_workstation = require('toni.utils').is_workstation

return {
    'dmmulroy/tsc.nvim',
    cond = is_workstation,
    cmd = 'TSC',
    opts = {
        -- enable_progress_notifications = false,
    },
}
