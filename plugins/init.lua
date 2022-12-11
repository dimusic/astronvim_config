local cmp_config = require "cmp"
local neo_tree_config = require "neo-tree"
local aerial_config = require "aerial"
local null_ls_config = require "null-ls"
local telescope_config = require "telescope"

local plugins = {
    { "sainnhe/everforest" },
    { "joshdick/onedark.vim" },
    { "rose-pine/neovim" },

    { "xiyaowong/nvim-transparent" },

    { "RRethy/vim-illuminate" },
    {
        "simrat39/rust-tools.nvim",
        after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
        config = function()
            require("rust-tools").setup {
                server = astronvim.lsp.server_settings "rust_analyzer", -- get the server settings and built in capabilities/on_attach
            }
        end,
    },
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup {
                -- Configuration here, or leave empty to use defaults
            }
        end,
    },

    { "hrsh7th/cmp-nvim-lsp-signature-help", requires = {
        "hrsh7th/nvim-cmp",
    } },

    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup {
                -- mode = "topline",
                line_numbers = true,
            }
        end,
    },

    -- {
    --   "tzachar/cmp-tabnine",
    --   run = "./install.sh",
    --   requires = "hrsh7th/nvim-cmp",
    --   config = function() astronvim.add_user_cmp_source "cmp_tabnine" end,
    -- },

    {
        "anuvyklack/windows.nvim",
        requires = {
            "anuvyklack/middleclass",
            -- "anuvyklack/animation.nvim",
        },
        config = function()
            vim.o.winwidth = 10
            vim.o.winminwidth = 10
            vim.o.equalalways = false
            require("windows").setup()
        end,
    },

    { "vim-scripts/zoom.vim" },

    {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function() require("trouble").setup {} end,
    },

    -- copilot
    -- { "github/copilot.vim" },
    {
        "zbirenbaum/copilot.lua",
        event = "VimEnter",
        config = function()
            vim.defer_fn(function() require("copilot").setup() end, 100)
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function() require("copilot_cmp").setup() end,
    },

    {
        "wakatime/vim-wakatime",
    },
}

return {
    init = plugins,

    ["neo-tree"] = neo_tree_config,

    ["null-ls"] = null_ls_config,

    treesitter = {
        ensure_installed = { "lua", "javascript", "typescript", "tsx", "json", "rust" },
    },

    ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
        -- ensure_installed = { "" },
    },

    ["mason-null-ls"] = {
        ensure_installed = { "prettierd", "stylua" },
    },

    -- Aerial
    aerial = aerial_config,

    telescope = telescope_config,

    cmp = cmp_config,

    ["smart-splits"] = {
        tmux_integration = false,
    },

    notify = {
        background_colour = "#00000",
    },
}
