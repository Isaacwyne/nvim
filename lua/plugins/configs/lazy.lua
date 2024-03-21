local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("plugins.configs.others").luasnip(opts)
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
      },
    },
    opts = function()
      return require "plugins.configs.cmp"
    end,
    config = function(_, opts)
      local present, cmp = pcall(require, "cmp")
      if not present then
        return
      end
      cmp.setup(opts)
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = "$",
        check_comma = true,
        manual_position = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
      disable_filetype = {
        "TelescopePrompt",
        "spectre_panel",
        "vim",
      },
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)

      -- setup cmp for autopairs
      local present, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
      local cmp_setup, cmp = pcall(require, "cmp")
      if not present and cmp_setup then
        return
      end
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- Tools
  {
    "ThePrimeagen/harpoon",
    event = { "VeryLazy" },
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")
      vim.keymap.set("n", "<leader>ma", mark.add_file, { desc = "Harpoon: Mark File"})
      vim.keymap.set("n", "<leader><leader>f", ui.toggle_quick_menu, { desc = "Toggle Harpoon Menu" })
      vim.keymap.set("n", "<C-t>", function() ui.nav_file(1) end, { desc = "Harpoon File 1"})
      vim.keymap.set("n", "<C-s>", function() ui.nav_file(2) end, { desc = "Harpoon File 2"})
      vim.keymap.set("n", "<C-b>", function() ui.nav_file(3) end, { desc = "Harpoon File 3"})
      vim.keymap.set("n", "<C-g>", function() ui.nav_file(4) end, { desc = "Harpoon File 4"})
    end
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufWinEnter", "BufNewFile" },
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "Telescope",
    init = function()
      require("core.utils").load_mappings "telescope"
    end,
    opts = function()
      return require "plugins.configs.telescope"
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extension
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function()
      require("core.utils").load_mappings "nvimtree"
    end,
    opts = function()
      return require("plugins.configs.others").nvimtree
    end,
    config = function()
      require("nvim-tree").setup(opts)
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    opts = function()
      return require("plugins.configs.others").mason
    end,
    config = function(_, opts)
      require("mason").setup(opts)

      vim.api.nvim_create_user_command("MasonInstallAll", function()
      vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },

  -- UI --
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
      init = function()
        require("lazy.core.loader").disable_rtp_plugin "nvim-treesitter-textobjects"
        load_textobjects = true
      end,
    },
    cmd = { "TSUpdateSync" },
    opts = function()
      return require "plugins.configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "navarasu/onedark.nvim",
    lazy = false,
    dependencies = {
      "NvChad/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup()
      end,
    },
    opts = function()
      return require("plugins.configs.ui").colorscheme
    end,
    config = function(_, opts)
      local present, onedark = pcall(require, "onedark")
      if not present then
        return
      end
      onedark.setup(opts)
      onedark.load()
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    version = "2.20.7",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      return require("plugins.configs.ui").blankline
    end,
    config = function(_, opts)
      require("core.utils").load_mappings "blankline"
      require("indent_blankline").setup(opts)
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "gitcommit", "diff" },
    opts = function()
      return require("plugins.configs.ui").gitsigns
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    opts = function()
      return require("plugins.configs.ui").statusline
    end,
    config = function(_, opts)
      require("lualine").setup(opts)
    end,
  },

  {
    "akinsho/bufferline.nvim",
    event = "BufReadPre",
    opts = function()
      return require("plugins.configs.ui").bufferline
    end,
    config = function(_, opts)
      require("bufferline").setup(opts)
    end,
  },

  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require "plugins.configs.alpha"
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = function()
      return require("plugins.configs.others").conform
    end,
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = function()
      return require("plugins.configs.ui").noice
    end,
  },

  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    -- event = "VimEnter",
    cmd = "WhichKey",
    init = function()
      require("core.utils").load_mappings "whichkey"
    end,
    config = function(_, opts)
      require("which-key").setup(opts)
    end,
  },

  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    init = function()
      require("core.utils").load_mappings "comment"
    end,
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },
}

local opts = {
  defaults = {
    version = false,
  },
  ui = {
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
  },

  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
}

require("lazy").setup(plugins, opts)
