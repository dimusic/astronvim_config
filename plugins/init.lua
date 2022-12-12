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
    -- {
    --     "zbirenbaum/copilot.lua",
    --     event = "VimEnter",
    --     config = function()
    --         vim.defer_fn(function() require("copilot").setup() end, 100)
    --     end,
    -- },
    -- {
    --     "zbirenbaum/copilot-cmp",
    --     after = { "copilot.lua" },
    --     config = function() require("copilot_cmp").setup() end,
    -- },

    -- tabnine
    {
        "tzachar/cmp-tabnine",
        run = "./install.sh",
        requires = "hrsh7th/nvim-cmp",
        config = function()
            local tabnine = require "cmp_tabnine.config"

            tabnine:setup {
                max_num_results = 3,
            }

            -- tabnine:setup {
            --     -- max_lines = 1000,
            --     max_num_results = 3,
            --     sort = true,
            --     -- run_on_every_keystroke = true,
            --     snippet_placeholder = "..",
            --     ignored_file_types = {
            --         -- default is not to ignore
            --         -- uncomment to ignore in lua:
            --         -- lua = true
            --     },
            --     show_prediction_strength = true,
            -- }
        end,
    },

    {
        "karb94/neoscroll.nvim",
    },

    {
        "wakatime/vim-wakatime",
    },
}

return plugins
