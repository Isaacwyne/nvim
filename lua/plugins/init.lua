return {
  -- load luasnips + cmp related in insert mode only {{{
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
      },
    },
    opts = function()
      return require "plugins.configs.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },
  -- }}}

  -- indentline {{{
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      return require("plugins.configs.others").blankline
    end,
    config = function(_, opts)
      require("indent_blankline").setup(opts)
    end,
  },
  -- }}}

  -- treesitter {{{
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
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
  -- }}}

  -- gitsigns {{{
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "gitcommit", "diff" },
    opts = function()
      return require("plugins.configs.others").gitsigns
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },
  -- }}}

  -- lsp stuff {{{
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    opts = function()
      return require "plugins.configs.mason"
    end,
    config = function(_, opts)
      require("mason").setup(opts)

      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})
      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },

  {
    "lambdalisue/suda.vim",
    cmd = { "SudaWrite", "SudaRead" },
  },
  -- }}}

  {
    "neovim/nvim-lspconfig",
    init = function()
      require("core.utils").lazy_load "nvim-lspconfig"
    end,
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

  -- comments {{{
  --[[ {
    "numToStr/Comment.nvim",
    keys = { "gc", "gb" },
    opts = function()
      return require("plugins.configs.others").comment
    end,
    config = function()
      require("Comment").setup()
    end,
  }, ]]
  -- }}}

  -- file managing, picker etc {{{
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function()
      require("core.utils").load_mappings "nvimtree"
    end,
    opts = function()
      return require "plugins.configs.nvimtree"
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
      vim.g.nvimtree_side = opts.view.side
    end,
  },
  -- }}}

  -- Telescope {{{
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
  -- }}}

  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },

  -- mini.nvim {{{
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("mini.indentscope").setup()
      require("mini.pairs").setup()
      require("mini.surround").setup()
      require("mini.comment").setup {
        options = {
          custom_commentstring = function()
            return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
          end,
        },
      }
    end,
  },
  -- }}}

  -- statusline {{{
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    opts = function()
      return require "plugins.configs.statusline"
    end,
    config = function(_, opts)
      require("lualine").setup(opts)
    end,
  },
  -- }}}

  -- bufferline {{{
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    opts = function()
      return require("plugins.configs.others").bufferline
    end,
    config = function(_, opts)
      require("bufferline").setup(opts)
    end,
  },
  -- }}}

  -- vim which-key {{{
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    init = function()
      require("core.utils").load_mappings "whichkey"
    end,
    config = function(_, opts)
      require("which-key").setup(opts)
    end,
  },
  -- }}}

  -- colorscheme {{{
  {
    "navarasu/onedark.nvim",
    dependencies = {
      "norcalli/nvim-colorizer.lua",
      event = "BufRead",
      config = function()
        require("colorizer").setup()
      end,
    },
  },
  -- }}}

  -- greeter (welcome) {{{
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      return require "plugins.configs.greeter"
    end,
    config = function(_, dashboard)
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end
      require("alpha").setup(dashboard.opts)
    end,
  },
  -- }}}

  -- null-ls {{{
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require "null-ls"
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nls.builtins.formatting.black,
          nls.builtins.formatting.prettierd,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.jq,
          nls.builtins.code_actions.gitsigns,
          nls.builtins.diagnostics.mypy,
          nls.builtins.diagnostics.ruff,
        },
      }
    end,
  },
}
-- }}}
