require("base")
require("autocmds")
require("options")
require("keymaps")
require("colorscheme")
require("plugins")

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {
        'fern',
        'nerdtree',
        'nvim-tree',
        'fzf',
        'quickfix'
    }
}

require('lualine').get_config()

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup { indent = { highlight = highlight } }


vim.opt.termguicolors = true
require("bufferline").setup {}
require("nvim-autopairs").setup {}
require("nvim-autopairs").enable()

vim.cmd([[au BufNewFile,BufRead *.v set filetype=vlang]])

local status_ok, noice = pcall(require, "noice")

noice.setup {
    views = {
        cmdline_popup = {
            position = {
                row = "40%",
                col = "50%",
            },
            size = {
                width = 60,
                height = "auto",
            },
            border = {
                style = "rounded",
                padding = { 0, 1 },
            },
            win_options = {
                winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
            },
        },
        popupmenu = {
            relative = "editor",
            position = {
                row = "50%",
                col = "50%",
            },
            size = {
                width = 60,
                height = 10,
            },
            border = {
                style = "rounded",
                padding = { 0, 1 },
            },
            win_options = {
                winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
            },
        },
    },
    cmdline = {
        format = {
            cmdline = { pattern = "^:", icon = "", lang = "vim" },
            search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
            filter = { pattern = "^:%s*!", icon = "", lang = "bash" },
            lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
            help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
            input = {}, -- Used by input()
        },
    },
    messages = {
        enabled = true,
        view = "mini", -- redirect messages to mini
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = false,
    },
    lsp = {
        progress = { enabled = false },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
        hover = { view = "hover" },
        signature = { view = "hover" },
    },
    -- you can enable a preset for easier configuration
    presets = {
        -- bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false,      -- position the cmdline and popupmenu together
        long_message_to_split = false, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
    },
}

require 'cmp'.setup {
    sources = {
        { name = 'nvim_lsp_signature_help' }
    }
}

local rt = require("rust-tools")

rt.setup({
    server = {
        on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
    },
})

require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "vls", "haxe_language_server" },
    automatic_installation = true,
    handlers = nil,
}

require('mason').setup {
    ui = {
        check_outdated_packages_on_open = true,
        border = 'single',
    },
}

require('nvim-navic').setup {
    lsp = {
        auto_attach = true,
    },
    highlight = true,
}

require("solarized-osaka").setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    transparent = true,     -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark",            -- style for sidebars, see below
        floats = "dark",              -- style for floating windows
    },
    sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = true,              -- dims inactive windows
    lualine_bold = true,              -- When `true`, section headers in the lualine theme will be bold

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    --@param colors ColorScheme
    on_colors = function(colors) end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    --@param highlights Highlights
    --@param colors ColorScheme
    on_highlights = function(highlights, colors) end,
})

require("terminal").setup()

require('dap-ruby').setup()

require('Comment').setup()

require('nvim-treesitter.configs').setup {
    endwise = {
        enable = true,
    },
}

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})

if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
    vim.o.guifont = "Mononoki Nerd Font:h28:i" -- text below applies for VimScript
    vim.g.neovide_scroll_animation_far_lines = 1
    vim.g.neovide_fullscreen = true
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_underline_stroke_scale = 1.0
    vim.g.neovide_theme = 'auto'
    vim.g.neovide_input_ime = true
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = true
    vim.g.neovide_cursor_vfx_mode = "railgun"
    vim.g.neovide_cursor_animation_length = 0.1
    local function set_ime(args)
        if args.event:match("Enter$") then
            vim.g.neovide_input_ime = true
        else
            vim.g.neovide_input_ime = false
        end
    end

    local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

    vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
        group = ime_input,
        pattern = "*",
        callback = set_ime
    })

    vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
        group = ime_input,
        pattern = "[/\\?]",
        callback = set_ime
    })
end

require("scrollbar").setup()

require 'lspconfig'.julials.setup {
    on_new_config = function(new_config, _)
        local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
        if require 'lspconfig'.util.path.is_file(julia) then
            vim.notify("Hello!")
            new_config.cmd[1] = julia
        end
    end
}

require('treepin').setup {
    hide_onscreen = true,  -- Hide's the pin buffer when the text of the pin is visible.
    max_height = 30,       -- Prevents the pin buffer from displaying when the pin is larger than x lines.
    position = 'relative', -- May be 'relative', 'top', or 'bottom'. Determines the position of the pin buffer within the window.
    icon = '>',            -- The icon to display in the sign column at the top of the pin. Set to nil to prevent the sign column being used.
    zindex = 50,           -- The Z-index of the pin buffer.
    separator = nil,       -- A single character that may be used as a separator between the editing buffer and the pin buffer.
}

require("flutter-tools").setup {} -- use defaults

require('trim').setup()

require("inlay-hints").setup()

local ih = require("inlay-hints")
local lspconfig = require("lspconfig")

lspconfig.sumneko_lua.setup({
    on_attach = function(c, b)
        ih.on_attach(c, b)
    end,
    settings = {
        Lua = {
            hint = {
                enable = true,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
        },
    },
})

require("rust-tools").setup({
    tools = {
        on_initialized = function()
            ih.set_all()
        end,
        inlay_hints = {
            auto = false,
        },
    },
    server = {
        on_attach = function(c, b)
            ih.on_attach(c, b)
        end,
    },
})

lspconfig.tsserver.setup({
    on_attach = function(c, b)
        ih.on_attach(c, b)
    end,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" },
    settings = {
        javascript = {
            inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
            },
        },
        typescript = {
            inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
            },
        },
    },
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.json.used_by = "jsonc"
-- tailwindcss
parser_config.html.used_by = "svelte"
parser_config.css.used_by = "svelte"
parser_config.javascript.used_by = "svelte"
parser_config.typescript.used_by = "svelte"
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
parser_config.svelte = {
    install_info = {
        url = ""
    },
    used_by = { "html", "javascript", "typescript" },
}

-- tailwindcss using lspconfig
lspconfig.html.setup({
    on_attach = function(c, b)
        ih.on_attach(c, b)
    end,
    filetypes = { "svelte" },
    cmd = { "html-languageserver", "--stdio" },
    settings = {
        html = {
            suggest = {
                typescript = {
                    enabled = true,
                },
            },
        },
    },
})

lspconfig.cssls.setup({
    on_attach = function(c, b)
        ih.on_attach(c, b)
    end,
    filetypes = { "svelte" },
    cmd = { "css-languageserver", "--stdio" },
    settings = {
        css = {
            suggest = {
                typescript = {
                    enabled = true,
                },
            },
        },
    },
})

lspconfig.tsserver.setup({
    on_attach = function(c, b)
        ih.on_attach(c, b)
    end,
    filetypes = { "svelte" },
    cmd = { "typescript-language-server", "--stdio" },
    settings = {
        javascript = {
            suggest = {
                typescript = {
                    enabled = true,
                },
            },
        },
        typescript = {
            suggest = {
                typescript = {
                    enabled = true,
                },
            },
        },
    },
})

lspconfig.svelte.setup({
    on_attach = function(c, b)
        ih.on_attach(c, b)
    end,
    filetypes = { "svelte" },
    cmd = { "svelteserver", "--stdio" },
    settings = {
        svelte = {
            plugin = {
                css = {
                    enable = true,
                },
                html = {
                    enable = true,
                },
                script = {
                    enable = true,
                },
            },
        },
    },
})

require("nvim-treesitter.configs").setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
    },
    refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = true },
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
    },
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
    },
}

require('cmp').setup.filetype({ 'lisp' }, {
    sources = {
        { name = 'nvlime' }
    }
})

lspconfig.racket_langserver.setup {}

-- Function to simulate getting a list of all packages containing "vim" in their name
function QuicklispSystemApropos(package_name)
    -- Simulated data retrieval (replace this with actual logic to query Quicklisp)
    local packages = {
        "vim-lisp",
        "slime-vim",
        "quicklisp-vim",
        "vim-utilities",
        "common-vim"
    }
    -- Filter packages based on the package_name substring
    local filtered_packages = {}
    for _, pkg in ipairs(packages) do
        if string.find(pkg, package_name) then
            table.insert(filtered_packages, pkg)
        end
    end
    return filtered_packages
end

-- Function to simulate getting a list of all packages depending on 'cl-messagepack'
function QuicklispWhoDependsOn(dependency)
    -- Simulated data retrieval (replace this with actual logic to query Quicklisp)
    local packages = {
        "cl-websocket",
        "cl-rest-client",
        "cl-serialization",
        "cl-messagepack-utils"
    }
    -- Assuming all these packages depend on 'cl-messagepack'
    return packages
end

-- Retrieve packages with "vim" in their name
local vim_packages = QuicklispSystemApropos('vim')
-- Retrieve packages depending on 'cl-messagepack'
local msgpack_packages = QuicklispWhoDependsOn('cl-messagepack')

-- Print results
print("Packages containing 'vim':")
for _, pkg in ipairs(vim_packages) do
    print(pkg)
end

print("Packages depending on 'cl-messagepack':")
for _, pkg in ipairs(msgpack_packages) do
    print(pkg)
end

require 'lspconfig.configs'.fennel_language_server = {
    default_config = {
        -- replace it with true path
        cmd = { '/Users/mio-dokuhaki/.cargo/bin/fennel-language-server' },
        filetypes = { 'fennel' },
        single_file_support = true,
        -- source code resides in directory `fnl/`
        root_dir = lspconfig.util.root_pattern("fnl"),
        settings = {
            fennel = {
                workspace = {
                    -- If you are using hotpot.nvim or aniseed,
                    -- make the server aware of neovim runtime files.
                    library = vim.api.nvim_list_runtime_paths(),
                },
                diagnostics = {
                    globals = { 'vim' },
                },
            },
        },
    },
}

lspconfig.fennel_language_server.setup {}

require("inc_rename").setup {
    cmd_name = "IncRename",     -- the name of the command
    hl_group = "Substitute",    -- the highlight group used for highlighting the identifier's new name
    preview_empty_name = false, -- whether an empty new name should be previewed; if false the command preview will be cancelled instead
    show_message = true,        -- whether to display a `Renamed m instances in n files` message after a rename operation
    input_buffer_type = nil,    -- the type of the external input buffer to use (the only supported value is currently "dressing")
    post_hook = nil,            -- callback to run after renaming, receives the result table (from LSP handler) as an argument
}

require('lspconfig').sqls.setup {
    on_attach = function(client, bufnr)
        require('sqls').on_attach(client, bufnr)
    end
}

vim.g.lisp_host_enable_tests = 1

lspconfig.scheme_langserver.setup {}

lspconfig.guile_ls.setup {}

lspconfig.emmet_ls.setup {}

lspconfig.racket_langserver.setup {}

require 'lspconfig.configs'.lsp_wl = {
    default_config = {
    cmd = {
      "wolfram",
      "kernel",
      "-noinit",
      "-noprompt",
      "-nopaclet",
      "-noicon",
      "-nostartuppaclets",
      "-run",
      'Needs["LSPServer`"];LSPServer`StartServer[]',
    },
    filetypes = { "mma", "wl" },
    root_dir = nvim_lsp.util.path.dirname,
  },
}

nvim_lsp.lsp_wl.setup({ on_attach = lsp_attach({}) })
