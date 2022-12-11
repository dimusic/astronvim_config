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

        -- example for addings schemas to yamlls
        -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
        --   settings = {
        --     yaml = {
        --       schemas = {
        --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
        --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
        --       },
        --     },
        --   },
        -- },
        -- Example disabling formatting for a specific language server
        -- gopls = { -- override table for require("lspconfig").gopls.setup({...})
        --   on_attach = function(client, bufnr)
        --     client.resolved_capabilities.document_formatting = false
        --   end
        -- }
    },
}
