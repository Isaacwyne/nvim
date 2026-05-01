return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.surround').setup()
      require('mini.comment').setup()
      require('mini.pairs').setup()
      require('mini.indentscope').setup()
      require('mini.cursorword').setup()
      require('mini.trailspace').setup()
      require('mini.notify').setup()
      require('mini.icons').setup()

      -- Statusline
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },

  -- gitsigns
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '\u{2590}' }, -- ▏
        change = { text = '\u{2590}' }, -- ▐
        delete = { text = '\u{2590}' }, -- ◦
        topdelete = { text = '\u{25e6}' }, -- ◦
        changedelete = { text = '\u{25cf}' }, -- ●
        untracked = { text = '\u{25cb}' }, -- ○
      },
      signcolumn = true,
      current_line_blame = false,
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })
      end,
    },
  },
}
