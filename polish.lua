local polish = function()
    -- Set key binding
    -- Set autocommands
    vim.api.nvim_create_augroup("packer_conf", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
        desc = "Sync packer after modifying plugins.lua",
        group = "packer_conf",
        pattern = "plugins.lua",
        command = "source <afile> | PackerSync",
    })

    vim.api.nvim_set_keymap("n", "<leader><leader>", "<C-^>", { noremap = true })

    vim.api.nvim_set_keymap(
        "n",
        "<leader>o",
        "<cmd>Neotree reveal<cr>",
        { noremap = true, silent = true, desc = "Reveal File in the Explorer" }
    )

    vim.api.nvim_set_keymap(
        "n",
        "<S-h>",
        "<cmd>:lua require('smart-splits').move_cursor_left()<cr>",
        { noremap = true, silent = true, desc = "Move to left split" }
    )

    vim.api.nvim_set_keymap(
        "n",
        "<S-l>",
        "<cmd>:lua require('smart-splits').move_cursor_right()<cr>",
        { noremap = true, silent = true, desc = "Move to right split" }
    )

    vim.api.nvim_set_keymap(
        "x",
        "<leader>p",
        '"_dP<cr>',
        { noremap = true, silent = true, desc = "Paste without copy" }
    )

    vim.api.nvim_set_keymap(
        "n",
        "<leader>d",
        '"_d<cr>',
        { noremap = true, silent = true, desc = "Delete without copy" }
    )

    -- Trouble keybinds
    vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap(
        "n",
        "<leader>xw",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>xd",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { noremap = true, silent = true })

    vim.cmd [[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]]

    local font_size = 11

    if vim.fn.has "win32" then vim.opt.guifont = { "FiraCode NF", ":h" .. font_size } end
    if vim.loop.os_uname().sysname == "Darwin" then
        vim.opt.guifont = { "FiraCode Nerd Font", ":h" .. (font_size + 1) }
    end

    vim.g.neovide_remember_window_size = true

    vim.g.transparent_enabled = true
end

return polish
