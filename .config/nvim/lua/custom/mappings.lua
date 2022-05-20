------------
-- Basics --
------------
-- map("n", "V", "vg_")
-- map("n", "vv", "V")
-- map("n", "L", "g_")
-- map("n", "H", "^")
-- -- move lines up and down in visual mode
-- map("v", "J", "'>+1<CR>gv=gv")
-- map("v", "K", "'<-2<CR>gv=gv")
-- -- keeping search results centered
-- map("n", "n", "nzzzv")
-- map("n", "N", "Nzzzv")
-- -- keeping cursor on join centered
-- local function join()
--     local pos = vim.api.nvim_win_get_cursor(0)
--     vim.cmd "norm! J"
--     vim.api.nvim_win_set_cursor(0, pos)
-- end
-- map("n", "J", join, { silent = true })

local M = {}

M.disabled = {
    n = {
        ["<leader>th"] = "",
        ["<leader>ph"] = "",
        ["<leader>e"] = "",
        ["C-i"] = "",
    }
}

M.bufferline = {}
M.nvterm = {}
M.whichkey = {}

M.general = {

}

M.telescope = {
    n = {
        -- file finding
        ["<leader>F"] = { "<cmd> Telescope <CR>", "  open Telescope" },
        ["<leader>fo"] = { function() require("telescope.builtin").oldfiles({only_cwd=true}) end, "  find oldfiles"},
        ["<leader>ft"] = { "<cmd> Telescope themes <CR>", "  find themes" },
        ["<leader>fk"] = { "<cmd> Telescope keymaps <CR>", "  show keys" },
        -- git integration
        ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "  find git commits" },
        ["<leader>gs"] = { "<cmd> Telescope git_status <CR>", "  find git changes" }
    },
}

M.lspconfig = {
    n = {
      ["<leader>ac"] = {
         function()
            vim.lsp.buf.rename()
         end,
         "   lsp rename",
      },
      ["<leader>aa"] = {
         function()
            vim.lsp.buf.code_action()
         end,
         "   lsp code_action",
      },
      ["]d"] = {
         function()
            vim.diagnostic.goto_next()
         end,
         "   goto prev",
      },
      ["<leader>="] = {
         function()
            vim.lsp.buf.formatting()
         end,
         "   lsp formatting",
      },
      ["<leader>sa"] = {
         function()
            vim.lsp.buf.add_workspace_folder()
         end,
         "   add workspace folder",
      },
      ["<leader>sr"] = {
         function()
            vim.lsp.buf.remove_workspace_folder()
         end,
         "   remove workspace folder",
      },
      ["<leader>sl"] = {
         function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
         end,
         "   list workspace folders",
      },
      ["<leader>f"] = {
         function()
            vim.diagnostic.open_float()
         end,
         "   floating diagnostic",
      },
      ["<C-k>"] = {
         function()
            vim.lsp.buf.signature_help()
         end,
         "   lsp signature_help",
      },
    }
}

M.harpoon = {
    n = {
        ["gh"] = { function() require('harpoon.mark').toggle_file() end, "toggle harpoon mark" },
        ["]h"] = { function() require('harpoon.ui').nav_next() end, "navigate to next harpoon file" },
        ["[h"] = { function() require('harpoon.ui').nav_prev() end, "navigate to previous harpoon file" },
        ["gH"] = { function() require('harpoon.ui').toggle_quick_menu() end, "show harpoon menu" },
    }
}
-- map("n", "<leader>fH", ":Telescope harpoon marks <CR>", { silent = true })
-- map("n", "gt", ":lua require('harpoon.cmd-ui').toggle_quick_menu() <CR>", { silent = true })
-- TODO: add an expression to call like 1gh or gh1
-- map("n", "gh", ":lua require('harpoon.ui').nav_file(vim.v.count) <CR>", { expr = true, silent = true })
-- map("n", "gh1", ":lua require('harpoon.ui').nav_file(1) <CR>", { silent = true })
-- map("n", "gh2", ":lua require('harpoon.ui').nav_file(2) <CR>", { silent = true })
-- map("n", "gh3", ":lua require('harpoon.ui').nav_file(3) <CR>", { silent = true })
-- map("n", "gh4", ":lua require('harpoon.ui').nav_file(4) <CR>", { silent = true })
-- map("n", "gh5", ":lua require('harpoon.ui').nav_file(5) <CR>", { silent = true })
-- map("n", "gh6", ":lua require('harpoon.ui').nav_file(6) <CR>", { silent = true })
-- map("n", "gh7", ":lua require('harpoon.ui').nav_file(7) <CR>", { silent = true })
-- map("n", "gh8", ":lua require('harpoon.ui').nav_file(8) <CR>", { silent = true })
-- map("n", "gh9", ":lua require('harpoon.ui').nav_file(9) <CR>", { silent = true })
-- map("n", "<C-1>", ":lua require('harpoon.ui').nav_file(1) <CR>", { silent = true })
-- map("n", "<C-2>", ":lua require('harpoon.ui').nav_file(2) <CR>", { silent = true })
-- map("n", "<C-3>", ":lua require('harpoon.ui').nav_file(3) <CR>", { silent = true })
-- map("n", "<C-4>", ":lua require('harpoon.ui').nav_file(4) <CR>", { silent = true })
-- map("n", "<C-5>", ":lua require('harpoon.ui').nav_file(5) <CR>", { silent = true })
-- map("n", "<C-6>", ":lua require('harpoon.ui').nav_file(6) <CR>", { silent = true })
-- map("n", "<C-7>", ":lua require('harpoon.ui').nav_file(7) <CR>", { silent = true })
-- map("n", "<C-8>", ":lua require('harpoon.ui').nav_file(8) <CR>", { silent = true })
-- map("n", "<C-9>", ":lua require('harpoon.ui').nav_file(9) <CR>", { silent = true })

M.git_signs = {
    ["<leader>gb"] = { "<cmd> Gitsigns blame_line <CR>" }
}

return M
