return {
    on_first_symbols = function(bufnr)
        -- local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
        -- if ft == "lua" then
        require("aerial").tree_set_collapse_level(bufnr, 1)
        -- end
    end,
    on_attach = function(_, bufnr)
        -- Jump up the tree with '[[' or ']]'
        vim.keymap.set(
            "n",
            "[[",
            ":lua require('aerial').prev()<cr>",
            { buffer = bufnr, desc = "Jump up and backwards in Aerial" }
        )
        vim.keymap.set(
            "n",
            "]]",
            ":lua require('aerial').next()<cr>",
            { buffer = bufnr, desc = "Jump up and forwards in Aerial" }
        )
    end,
}
