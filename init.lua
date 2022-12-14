local lsp_config = require "user.lsp"

local config = {
    updater = {
        remote = "origin", -- remote to use
        channel = "nightly", -- "stable" or "nightly"
        version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
        branch = "main", -- branch name (NIGHTLY ONLY)
        commit = nil, -- commit hash (NIGHTLY ONLY)
        pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
        skip_prompts = false, -- skip prompts about breaking changes
        show_changelog = true, -- show the changelog after performing an update
        auto_reload = false, -- automatically reload and sync packer after a successful update
        auto_quit = false, -- automatically quit the current session after a successful update
    },

    -- colorscheme = "rose-pine",
    colorscheme = "everforest",
    -- colorscheme = "onedark",

    highlights = {
        default_theme = function(highlights)
            -- local C = require "default_theme.colors"
            --
            -- highlights.Normal = { fg = C.fg, bg = C.bg }
            -- return highlights
        end,
    },

    options = {
        opt = {
            autoread = true,
            relativenumber = true, -- sets vim.opt.relativenumber
            tabstop = 4,
            shiftwidth = 4,
            completeopt = { "menuone", "noselect", "noinsert" },

            swapfile = false,
            backup = false,
            scrolloff = 8,
            updatetime = 100,
            colorcolumn = "120",
        },
        g = {
            mapleader = " ", -- sets vim.g.mapleader
            cmp_enabled = true,
            autopairs_enabled = true,
            diagnostics_enabled = true,
            status_diagnostics_enabled = true,
            everforest_better_performance = 1,
            everforest_background = "hard",
        },
    },

    header = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
    },

    default_theme = {
        -- diagnostics_style = { italic = true },
        colors = {
            -- fg = "#abb2bf",
            -- bg = "#1e222a",
        },

        highlights = function(hl)
            local C = require "default_theme.colors"

            hl.Normal = { fg = C.fg, bg = C.bg }

            -- New approach instead of diagnostic_style
            hl.DiagnosticError.italic = true
            hl.DiagnosticHint.italic = true
            hl.DiagnosticInfo.italic = true
            hl.DiagnosticWarn.italic = true

            return hl
        end,

        -- enable or disable highlighting for extra plugins
        plugins = {
            aerial = true,
            beacon = true,
            bufferline = true,
            dashboard = true,
            highlighturl = true,
            hop = false,
            indent_blankline = true,
            lightspeed = false,
            ["neo-tree"] = true,
            notify = true,
            ["nvim-tree"] = false,
            ["nvim-web-devicons"] = true,
            rainbow = true,
            symbols_outline = false,
            telescope = true,
            vimwiki = false,
            ["which-key"] = true,
        },
    },

    -- Diagnostics configuration (for vim.diagnostics.config({...}))
    diagnostics = {
        virtual_text = true,
        underline = true,
    },

    -- Extend LSP configuration
    lsp = lsp_config,

    mappings = {
        n = {
            -- second key is the lefthand side of the map
            -- mappings seen under group name "Buffer"
            ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
            ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
            ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
            ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
            ["<C-w>z"] = { "<cmd>WindowsMaximize<cr>", desc = "Maximize window" },
        },
        t = {},
    },

    -- LuaSnip Options
    luasnip = {
        -- Add paths for including more VS Code style snippets in luasnip
        vscode_snippet_paths = {},
        -- Extend filetypes
        filetype_extend = {
            -- javascript = { "javascriptreact" },
        },
    },

    -- CMP Source Priorities
    -- modify here the priorities of default cmp sources
    -- higher value == higher priority
    -- The value can also be set to a boolean for disabling default sources:
    -- false == disabled
    -- true == 1000
    cmp = {
        source_priority = {
            -- cmp_tabnine = 1200,
            copilot = 1200,
            nvim_lsp = 1000,
            nvim_lsp_signature_help = 900,
            buffer = 500,
            path = 250,
            luasnip = 0,
        },
    },

    ["which-key"] = {
        register_mappings = {
            n = {
                ["<leader>"] = {
                    ["b"] = { name = "Buffer" },
                },
            },
        },
    },
}

return config
