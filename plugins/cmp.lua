local cmp = require "cmp"
local lspkind = require "lspkind"
-- local cmp_compare = require "cmp.config.compare"

local source_mapping = {
    -- cmp_tabnine = "[TN]",
    copilot = "🐔",
    nvim_lsp_signature_help = "🐷",
    nvim_lsp = "λsp",
    vsnip = "⋗",
    buffer = "🍌",
    path = "📁",
}

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match "^%s*$" == nil
end

return {
    sources = {
        { name = "copilot" },
        { name = "nvim_lsp_signature_help" },
        -- { name = "calc" },
        -- { name = "emoji" },
    },

    formatting = {
        fields = { "menu", "abbr", "kind" },
        format = function(entry, vim_item)
            vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
            vim_item.menu = source_mapping[entry.source.name]
            if entry.source.name == "cmp_tabnine" then
                local detail = (entry.completion_item.data or {}).detail
                vim_item.kind = ""
                if detail and detail:find ".*%%.*" then vim_item.kind = vim_item.kind .. " " .. detail end

                if (entry.completion_item.data or {}).multiline then vim_item.kind = vim_item.kind .. " " .. "[ML]" end
            end
            local maxwidth = 80
            vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
            return vim_item
        end,
    },

    mapping = {
        ["<CR>"] = cmp.mapping.confirm {
            -- this is the important line
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
                cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
            else
                fallback()
            end
        end),
    },

    sorting = {
        priority_weight = 2,
        comparators = {
            -- require("copilot_cmp.comparators").prioritize,
            -- require("copilot_cmp.comparators").score,

            -- cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },

    -- sorting = {
    --   priority_weight = 2,
    --   comparators = {
    --     -- compare.score_offset, -- not good at all
    --     cmp_compare.locality,
    --     cmp_compare.recently_used,
    --     cmp_compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
    --     cmp_compare.offset,
    --     cmp_compare.order,
    --     -- compare.scopes, -- what?
    --     -- compare.sort_text,
    --     -- compare.exact,
    --     -- compare.kind,
    --     -- compare.length, -- useless
    --
    --     -- require "cmp_tabnine.compare",
    --     -- cmp_compare.offset,
    --     -- cmp_compare.exact,
    --     -- cmp_compare.score,
    --     -- cmp_compare.recently_used,
    --     -- cmp_compare.kind,
    --     -- cmp_compare.sort_text,
    --     -- cmp_compare.length,
    --     -- cmp_compare.order,
    --   },
    -- },
}
