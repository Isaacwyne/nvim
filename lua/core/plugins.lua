-- Automatically run: PackerCompile
vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("PACKER", { clear = true }),
    pattern = "plugins.lua",
    command = "source <afile> | PackerCompile",
})

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
local packer = require('packer')

packer.init({
  auto_clean = true,
  compile_on_sync = true,
  git = { clone_timeout = 6000 },
  display = {
    working_sym = "󰅡",
    error_sym = "✘",
    done_sym = "󰄳",
    removed_sym = "󰚌",
    moved_sym = "",
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
})

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'akinsho/bufferline.nvim'
  use 'navarasu/onedark.nvim'
  use 'numToStr/Comment.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'lewis6991/gitsigns.nvim'
  -- Lua
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
      require("nvim-autopairs").setup{}
    end
  }

  use 'echasnovski/mini.surround'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }

  -- LSP Support
  use {
    "neovim/nvim-lspconfig",
    requires = {
      {                                      -- Optional
      'williamboman/mason.nvim',
      run = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional
      {'onsails/lspkind.nvim'},
      {'folke/lsp-colors.nvim'},
      {'jose-elias-alvarez/null-ls.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-cmdline'},


      -- snippets
      {'L3MON4D3/LuaSnip'},     -- Required
      {'saadparwaiz1/cmp_luasnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }

  use({
    "glepnir/lspsaga.nvim",
    opt = true,
    branch = "main",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({})
    end,
    requires = {
      {"nvim-tree/nvim-web-devicons"},
      --Please make sure you install markdown and markdown_inline parser
      {"nvim-treesitter/nvim-treesitter"}
    },
  })

  if packer_bootstrap then
    require('packer').sync()
  end
end)
