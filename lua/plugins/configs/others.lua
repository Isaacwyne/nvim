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
}
