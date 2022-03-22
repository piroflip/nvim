local M = {}

local utils = require "core.utils"

local packer_status_ok, packer = pcall(require, "packer")
if not packer_status_ok then
  return
end

packer.startup {
  function(use)
    -- Plugin manager
    use {
      "wbthomason/packer.nvim",
    }

    -- Lua functions
    use {
      "nvim-lua/plenary.nvim",
    }

    -- Popup API
    use {
      "nvim-lua/popup.nvim",
    }
    
    -- Boost startup time
    use {
      "nathom/filetype.nvim",
      config = function()
        vim.g.did_load_filetypes = 1
      end,
    }

    -- Better buffer closing
    use {
      "moll/vim-bbye",
    }

    -- Save cursor position
    use {
      "farmergreg/vim-lastplace",
    }

    -- File explorer
    use {
      "kyazdani42/nvim-tree.lua",
      cmd = "NvimTreeToggle",
      config = function()
        require("configs.nvim-tree").config()
      end,
    }

    -- Statusline
    use {
      "itchyny/lightline.vim",
    }
    
    -- VCSCommand
    use {
      "vim-scripts/vcscommand.vim",
    }

    -- Smooth escaping
    use {
      "max397574/better-escape.nvim",
      event = { "InsertEnter" },
      config = function()
        require("better_escape").setup {
          mapping = { "ii", "jj", "jk", "kj" },
          timeout = vim.o.timeoutlen,
          keys = "<ESC>",
        }
      end,
    }

    -- Keymaps popup
    use {
      "folke/which-key.nvim",
      config = function()
        require("configs.which-key").config()
      end,
    }

    -- Terminal
    use {
      "akinsho/nvim-toggleterm.lua",
      cmd = "ToggleTerm",
      config = function()
        require("configs.toggleterm").config()
      end,
    }

    -- Commenting
    use {
      "numToStr/Comment.nvim",
      event = "BufRead",
      config = function()
        require("configs.comment").config()
      end,
    }

    -- Fuzzy finder
    use {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      config = function()
        require("configs.telescope").config()
      end,
    }

    -- Fuzzy finder syntax support
    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
    }

    -- Syntax highlighting
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      event = "BufRead",
      cmd = {
        "TSInstall",
        "TSInstallInfo",
        "TSInstallSync",
        "TSUninstall",
        "TSUpdate",
        "TSUpdateSync",
        "TSDisableAll",
        "TSEnableAll",
      },
      config = function()
        require("configs.treesitter").config()
      end,
      requires = {
        {
          -- Parenthesis highlighting
          "p00f/nvim-ts-rainbow",
          after = "nvim-treesitter",
        },
        {
          -- Autoclose tags
          "windwp/nvim-ts-autotag",
          after = "nvim-treesitter",
        },
        {
          -- Context based commenting
          "JoosepAlviste/nvim-ts-context-commentstring",
          after = "nvim-treesitter",
        },
      },
    }

    -- Conflict motion
    use {
      "inkarkat/vim-ConflictMotions",
      event = "BufRead",
      requires = {
        {
          -- Count Jump
          "inkarkat/vim-CountJump",
          before = "vim-ConflictMotions",
        },
        {
          -- Common Library
          "inkarkat/vim-ingo-library",
          before = "vim-ConflictMotions",
        },
      },
    }

    -- Completion engine
    use {
      "hrsh7th/nvim-cmp",
      event = "BufRead",
      config = function()
        require("configs.cmp").config()
      end,
    }
    
    -- Buffer completion source
    use {
      "hrsh7th/cmp-buffer",
      after = "nvim-cmp",
    }

    -- Path completion source
    use {
      "hrsh7th/cmp-path",
      after = "nvim-cmp",
    }

    -- LSP completion source
    use {
      "hrsh7th/cmp-nvim-lsp",
    }

    -- LSP manager
    use {
      "williamboman/nvim-lsp-installer",
      event = "BufRead",
      cmd = {
        "LspInstall",
        "LspInstallInfo",
        "LspPrintInstalled",
        "LspRestart",
        "LspStart",
        "LspStop",
        "LspUninstall",
        "LspUninstallAll",
      },
    }

    -- Built-in LSP
    use {
      "neovim/nvim-lspconfig",
      event = "BufRead",
      config = function()
        require "configs.lsp"
      end,
    }

    -- LSP enhancer
    use {
      "tami5/lspsaga.nvim",
      event = "BufRead",
      config = function()
        require("configs.lsp.lspsaga").config()
      end,
    }

    -- BadWolf colorscheme
    use {
      "sjl/badwolf"
    }

    -- OneDark colorscheme
    use {
      "joshdick/onedark.vim"
    }
    
  end,
  config = {
    compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
    profile = {
      enable = true,
      threshold = 0.0001,
    },
    git = {
      clone_timeout = 300,
    },
    auto_clean = true,
    compile_on_sync = true,
  },
}

return M
