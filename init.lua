vim.o.background = "dark"

vim.o.shell = "/bin/zsh"

local config = {
        -- Configure AstroNvim updates
        updater = {
                remote = "origin",     -- remote to use
                channel = "stable",    -- "stable" or "nightly"
                version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
                branch = "main",       -- branch name (NIGHTLY ONLY)
                commit = nil,          -- commit hash (NIGHTLY ONLY)
                pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
                skip_prompts = false,  -- skip prompts about breaking changes
                show_changelog = true, -- show the changelog after performing an update
                auto_reload = true,    -- automatically reload and sync packer after a successful update
                auto_quit = true,      -- automatically quit the current session after a successful update
                -- remotes = { -- easily add new remotes to track
                --   "remote_name" = "https://remote_url.come/repo.git", -- full remote url
                --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
                --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
                -- },
        },
        -- Set colorscheme to use
        colorscheme = "gruvbox",
        -- Override highlight groups in any theme
        highlights = {
                -- duskfox = { -- a table of overrides/changes to the default
                --   Normal = { bg = "#000000" },
                -- },
                default_theme = function(highlights) -- or a function that returns a new table of colors to set
                        local C = require "default_theme.colors"

                        highlights.Normal = { fg = C.fg, bg = C.bg }
                        return highlights
                end,
        },
        -- set vim options here (vim.<first_key>.<second_key> =  value)
        options = {
                opt = {
                        relativenumber = true, -- sets vim.opt.relativenumber
                },
                g = {
                        mapleader = " ", -- sets vim.g.mapleader
                },
        },
        -- If you need more control, you can use the function()...end notation
        -- options = function(local_vim)
        --   local_vim.opt.relativenumber = true
        --   local_vim.g.mapleader = " "
        --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
        --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
        --
        --   return local_vim
        -- end,

        -- Set dashboard header
        header = {},
        -- Default theme configuration
        default_theme = {
                -- set the highlight style for diagnostic messages
                diagnostics_style = { italic = true },
                -- Modify the color palette for the default theme
                colors = {
                        fg = "#abb2bf",
                        bg = "#1e222a",
                },
                -- enable or disable highlighting for extra plugins
                plugins = {
                        aerial = true,
                        beacon = false,
                        bufferline = true,
                        dashboard = false,
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
                -- enable servers that you already have installed without mason
                servers = {},
                -- easily add or disable built in mappings added during LSP attaching
                mappings = {
                        n = {
                                -- ["<leader>lf"] = false -- disable formatting keymap
                        },
                },
                -- add to the global LSP on_attach function
                -- on_attach = function(client, bufnr)
                -- end,

                -- override the mason server-registration function
                -- server_registration = function(server, opts)
                --   require("lspconfig")[server].setup(opts)
                -- end,

                -- Add overrides for LSP server settings, the keys are the name of the server
                ["server-settings"] = {
                        pyright = {
                                venvPath = "~/.cache/pypoetry/virtualenvs/",
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
        },
        -- Mapping data with "desc" stored directly by vim.keymap.set().
        --
        -- Please use this mappings table to set keyboard mapping since this is the
        -- lower level configuration and more robust one. (which-key will
        -- automatically pick-up stored data by this setting.)
        mappings = {
                -- first key is the mode
                n = {
                        -- second key is the lefthand side of the map
                        -- mappings seen under group name "Buffer"
                        ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
                        ["<leader>c"] = { "<cmd>:bd<cr>", desc = "Pick to close" },
                        ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
                        ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
                        ["<leader>v"] = { "<cmd>:vsplit<cr>", desc = "Split screen" },
                        ["<leader>q"] = { "<cmd>:q!<CR>", desc = "Close and save" },
                        ["<leader>u"] = { "<cmd>:UndotreeToggle<CR><cmd>:UndotreeFocus<CR>", desc = "Show undotree" },
                        ["<leader>fw"] = { ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>" },
                        ["<leader>fs"] = { ":lua require('telescope.builtin').lsp_document_symbols()<CR>" },
                        ["<leader>fg"] = { ":lua require('telescope.builtin').jumplist()<CR>" },
                        ["<leader>d"] = { "" },
                        -- quick save
                        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
                },
                t = {
                        -- setting a mapping to false will disable it
                        -- ["<esc>"] = false,
                },
        },
        -- Configure plugins
        plugins = {
                -- You can disable default plugins as follows:
                -- ["goolord/alpha-nvim"] = { disable = true },
                -- You can also add new plugins here as well:
                -- Add plugins, the packer syntax without the "use"
                -- { "andweeb/presence.nvim" },
                { "j-hui/fidget.nvim" },
                { "morhetz/gruvbox" },
                { "mbbill/undotree" },
                { "simrat39/rust-tools.nvim" },
                { "tpope/vim-fugitive" },
                {
                        "williamboman/nvim-lsp-installer",
                        config = function()
                                require("nvim-lsp-installer").setup {
                                        automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
                                        ui = {
                                                icons = {
                                                        server_installed = "✓",
                                                        server_pending = "➜",
                                                        server_uninstalled = "✗",
                                                },
                                        },
                                }
                        end,
                        requires = { "neovim/nvim-lspconfig" },
                },
                {
                        "kylechui/nvim-surround",
                        tag = "*",
                        config = function() require("nvim-surround").setup {} end,
                },
                {
                        "Pocco81/auto-save.nvim",
                        lazy = false
                },
                { "nvim-telescope/telescope-live-grep-args.nvim" },
                -- We also support a key value style plugin definition similar to NvChad
                ["ray-x/lsp_signature.nvim"] = {
                        event = "BufRead",
                        config = function() require("lsp_signature").setup() end,
                },
                -- All other entries override the require("<key>").setup({...}) call for default plugins
                ["neo-tree"] = {
                        lazy = false,
                        requires = {
                                "nvim-lua/plenary.nvim",
                                "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
                                "MunifTanjim/nui.nvim",
                        },
                        window = {
                                position = "float",
                        },
                        filesystem = {
                                filtered_items = {
                                        visible = true,
                                },
                        },
                },
                treesitter = {
                        -- overrides `require("treesitter").setup(...)`
                        lazy = false,
                        auto_reload = true,
                        automatic_installation = true,
                        ensure_installed = { "lua", "rust", "typescript" },
                },
                -- use mason-lspconfig to configure LSP installations
                ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
                        lasy = false,
                        ensure_installed = { "sumneko_lua", "rust_analyzer", "tsserver" },
                },
                ["WhoIsSethDaniel/mason-tool-installer.nvim"] = {
                        after = "mason.nvim",
                        config = function()
                                require("mason-tool-installer").setup({
                                        -- your config for the plugin here
                                })
                        end,
                },
        },
        -- LuaSnip Options
        luasnip = {
                -- Add paths for including more VS Code style snippets in luasnip
                vscode_snippet_paths = {},
                -- Extend filetypes
                filetype_extend = {
                        javascript = { "javascriptreact" },
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
                        nvim_lsp = 1000,
                        luasnip = 750,
                        buffer = 500,
                        path = 250,
                },
        },
        -- Modify which-key registration (Use this with mappings table in the above.)
        ["which-key"] = {
                -- Add bindings which show up as group name
                register_mappings = {
                        -- first key is the mode, n == normal mode
                        n = {
                                -- second key is the prefix, <leader> prefixes
                                ["<leader>"] = {
                                        -- third key is the key to bring up next level and its displayed
                                        -- group name in which-key top level menu
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
                vim.filetype.add {
                        extension = {
                                js = "javascriptreact",
                                rust = "rust-analyzer",
                        },
                }
                -- Set up custom filetypes
                -- vim.filetype.add {
                --   extension = {
                --     foo = "fooscript",
                --   },
                --   filename = {
                --     ["Foofile"] = "fooscript",
                --   },
                --   pattern = {
                --     ["~/%.config/foo/.*"] = "fooscript",
                --   },
                -- }
        end,
}

return config
