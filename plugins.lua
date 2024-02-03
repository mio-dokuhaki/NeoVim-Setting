local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here

  use("petertriho/nvim-scrollbar")
  use{
      "lewis6991/gitsigns.nvim",
    config = function()
        require('gitsigns').setup()
        require("scrollbar.handlers.gitsigns").setup()
    end
  }
  use{
      "kevinhwang91/nvim-hlslens",
    config = function()
    -- require('hlslens').setup() is not required
        require("scrollbar.handlers.search").setup({
        -- hlslens config overrides
    })
    end,
  }
  use({
      "Dronakurl/injectme.nvim",
      dependencies = {
          "nvim-treesitter/nvim-treesitter",
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope.nvim",
      },
      cmd = { "InjectmeToggle", "InjectmeSave", "InjectmeInfo" , "InjectmeLeave"},
  })
  use{
      'KaitlynEthylia/TreePin',
      requires = {'nvim-treesitter/nvim-treesitter'},
      config = function() require('treepin').setup() end,
  }
  use{
      'xuhdev/vim-latex-live-preview',
      ft = 'tex',
  }
  use({ "wbthomason/packer.nvim" })
  use({ "nvim-lua/plenary.nvim" }) -- Common utilities
  use({ "nvim-lua/popup.nvim" })
  use({ "RRethy/vim-illuminate" })
  -- Colorschemes
  use({ "EdenEast/nightfox.nvim" }) -- Color scheme

  use({ "windwp/nvim-autopairs"}) -- Autopairs, integrates with both cmp and treesitter
  use({ "kyazdani42/nvim-web-devicons" }) -- File icons
  use({'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'})
  -- cmp plugins
  use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
  use({ "hrsh7th/cmp-buffer" }) -- buffer completions
  use({ "hrsh7th/cmp-path" }) -- path completions
  use({ "hrsh7th/cmp-cmdline" }) -- cmdline completions
  use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-nvim-lua" })
  use({ "onsails/lspkind-nvim" })
  use({ "hrsh7th/cmp-nvim-lsp-signature-help" })
  use({ "lfilho/cosco.vim" })
  use {
    'andymass/vim-matchup',
    setup = function()
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  }

  -- snippets
  use({ "L3MON4D3/LuaSnip" }) --snippet engine

  -- LSP
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
  use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
  use({ "tami5/lspsaga.nvim", branch = "main", after = "nvim-lspconfig" })
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  }
  -- Formatter
  use({ "MunifTanjim/prettier.nvim" })

  -- Telescope
  use({ "nvim-telescope/telescope.nvim" })

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" } })
  use({ "nvim-telescope/telescope-file-browser.nvim" })

  -- Lualime
  use {'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true }}

  -- NerdTree
  use({ "lambdalisue/fern.vim" })

  -- Nerdfont
  use({ "lambdalisue/nerdfont.vim" })

  -- coc.nvim
  use {'neoclide/coc.nvim', branch = 'release'}

  -- noice
  use({ "folke/noice.nvim" })
  use({ "MunifTanjim/nui.nvim" })

  --tabnine
  use({ "neoclide/coc-tabnine" })

  use({ "lukas-reineke/indent-blankline.nvim" })

  use({ "simrat39/rust-tools.nvim" })

  use({ "romgrk/barbar.nvim" })

  use({ "elixir-editors/vim-elixir" })

  use({ "cespare/vim-toml" })

  use({ "craftzdog/solarized-osaka.nvim" })

  use({ "tpope/vim-rails" })

  use({ "mrcjkb/haskell-tools.nvim" })

  use({ "kassio/neoterm" })

  use({
    'rebelot/terminal.nvim',
    config = function()
        require("terminal").setup()
    end
  })

  use({ "osyo-manga/vim-brightest" })

  use({ "mfussenegger/nvim-dap" })

  use({ "suketa/nvim-dap-ruby" })

  use({ "tpope/vim-endwise" })

  use({ "tpope/vim-surround" })

  use({ "github/copilot.vim" })

  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }
  use({ "nvim-tree/nvim-tree.lua" })
  use({ "udalov/kotlin-vim" })
  use({ "julialang/julia-vim" })
  use({ "SirVer/ultisnips" })
  use({ "knsh14/vim-github-link" })
  use({
      "ariel-frischer/bmessages.nvim",
      config = function()
          require("bmessages").setup({})
      end,
  })
  use {
      'cameron-wags/rainbow_csv.nvim',
      config = function()
          require 'rainbow_csv'.setup()
      end,
      -- optional lazy-loading below
      module = {
          'rainbow_csv',
          'rainbow_csv.fns'
      },
      ft = {
          'csv',
          'tsv',
          'csv_semicolon',
          'csv_whitespace',
          'csv_pipe',
          'rfc_csv',
          'rfc_semicolon'
      }
  }
  use {
      'akinsho/flutter-tools.nvim',
      requires = {
          'nvim-lua/plenary.nvim',
          'stevearc/dressing.nvim', -- optional for vim.ui.select
      },
  }
  use({ "David-Kunz/markid" })
  use({ "wakatime/vim-wakatime" })
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
