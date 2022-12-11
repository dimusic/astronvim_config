return function(config)
    local null_ls = require "null-ls"
    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
        -- Set a formatter
        null_ls.builtins.formatting.stylua.with {
            extra_args = { "--indent-type", "Spaces", "--indent-width", "4" },
        },
        null_ls.builtins.formatting.prettierd.with { extra_args = { "--print-width=120", "--tab-width=4" } },
    }
    return config -- return final config table to use in require("null-ls").setup(config)
end
