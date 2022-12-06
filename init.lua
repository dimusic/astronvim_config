--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local lspkind = require "lspkind"
-- local cmp_compare = require "cmp.config.compare"
local cmp = require "cmp"

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

local config = {

  -- Configure AstroNvim updates
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
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- colorscheme = "rose-pine",
  colorscheme = "everforest",
  -- colorscheme = "onedark",

  -- Override highlight groups in any theme
  highlights = {
    -- duskfox = { -- a table of overrides/changes to the default
    --   Normal = { bg = "#000000" },
    -- },
    -- everforest = {
    --   Normal = { bg = nil },
    --   EndOfBuffer = { bg = nil },
    -- },
    -- onedark = {
    --   Normal = { bg = nil },
    --   EndOfBuffer = { bg = nil },
    -- },
    default_theme = function(highlights) -- or a function that returns a new table of colors to set
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
  lsp = {
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
    },

    ["server-settings"] = {
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
  },

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

  -- Configure plugins
  plugins = {
    init = {
      -- ["L3MON4D3/LuaSnip"] = { disable = true },

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
    },

    ["neo-tree"] = {
      enable_diagnostics = false,
      filesystem = {
        follow_current_file = false,
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = true,
          always_show = {
            ".env",
          },
        },
      },

      window = {
        mappings = {
          H = "toggle_hidden",
          L = false,
        },
      },
    },

    ["null-ls"] = function(config)
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd.with { extra_args = { "--print-width=120", "--tab-width=4" } },
      }
      return config -- return final config table to use in require("null-ls").setup(config)
    end,
    treesitter = {
      -- ensure_installed = { "lua" },
    },
    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
      -- ensure_installed = { "" },
    },

    ["mason-null-ls"] = {
      ensure_installed = { "prettierd" },
    },

    -- Aerial
    aerial = {
      on_first_symbols = function(bufnr)
        -- local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
        -- if ft == "lua" then
        require("aerial").tree_set_collapse_level(bufnr, 1)
        -- end
      end,
      on_attach = function(_, bufnr)
        -- Jump up the tree with '[[' or ']]'
        vim.keymap.set("n", "[[", "<cmd>AerialPrevUp<cr>", { buffer = bufnr, desc = "Jump up and backwards in Aerial" })
        vim.keymap.set("n", "]]", "<cmd>AerialNextUp<cr>", { buffer = bufnr, desc = "Jump up and forwards in Aerial" })
      end,
    },

    telescope = {
      defaults = {
        sorting_strategy = "descending",
        layout_config = {
          horizontal = {
            prompt_position = "bottom",
          },
        },
      },
    },

    cmp = {
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
    },

    ["smart-splits"] = {
      tmux_integration = false,
    },

    notify = {
      background_colour = "#00000",
    },
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

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
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
  end,
}

return config
