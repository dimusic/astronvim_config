return {
    skip_setup = { "rust_analyzer" },

    servers = {
        -- "pyright"
    },

    mappings = {
        n = {
            ["<C-]>"] = { function() vim.lsp.buf.definition() end, desc = "Show the definition of current symbol" },

            ["<leader>]"] = { ":vsp<cr> :lua vim.lsp.buf.definition()<cr>", desc = "Definition in a new split" },
        },
    },

    formatting = {
        format_on_save = true,
        disabled = {
            "tsserver",
        },

        -- filter = function(client)
        --     if client.name == "sumneko_lua" then return false end
        -- end,
    },

    ["server-settings"] = {
        lua = {
            format = {
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "4",
                },
            },
        },
    },
}
