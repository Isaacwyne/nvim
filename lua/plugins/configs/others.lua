return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.surround').setup()

      -- Statusline
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- Autopairs
      local pairs = function()
        local opts = {
          modes = { insert = true, command = true, terminal = false },
          -- skip autopair when next character is one of these
          skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
          -- skip autopair when the cursor is inside these treesitter nodes
          skip_ts = { 'string' },
          -- skip autopair when next character is closing pair
          -- and there are more closing pairs than opening pairs
          skip_unbalanced = true,
          -- better deal with markdown code blocks
          markdown = true,
        }
        local pairs = require 'mini.pairs'
        pairs.setup(opts)
        local open = pairs.open
        pairs.open = function(pair, neigh_pattern)
          if vim.fn.getcmdline() ~= '' then
            return open(pair, neigh_pattern)
          end
          local o, c = pair:sub(1, 1), pair:sub(2, 2)
          local line = vim.api.nvim_get_current_line()
          local cursor = vim.api.nvim_win_get_cursor(0)
          local next = line:sub(cursor[2] + 1, cursor[2] + 1)
          local before = line:sub(1, cursor[2])
          if opts.markdown and o == '`' and vim.bo.filetype == 'markdown' and before:match '^%s*``' then
            return '`\n```' .. vim.api.nvim_replace_termcodes('<up>', true, true, true)
          end
          if opts.skip_next and next ~= '' and next:match(opts.skip_next) then
            return o
          end
          if opts.skip_ts and #opts.skip_ts > 0 then
            local ok, captures = pcall(vim.treesitter.get_captures_at_pos, 0, cursor[1] - 1, math.max(cursor[2] - 1, 0))
            for _, capture in ipairs(ok and captures or {}) do
              if vim.tbl_contains(opts.skip_ts, capture.capture) then
                return o
              end
            end
          end
          if opts.skip_unbalanced and next == c and c ~= o then
            local _, count_open = line:gsub(vim.pesc(pair:sub(1, 1)), '')
            local _, count_close = line:gsub(vim.pesc(pair:sub(2, 2)), '')
            if count_close > count_open then
              return o
            end
          end
          return open(pair, neigh_pattern)
        end
      end
      pairs()
    end,
  },

  -- useful plugin to show you pending keybinds
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down ',
          Left = '<Left ',
          Right = '<Right ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enable = true },
      indent = { enabled = true },
      quickfile = { enabled = true },
    },
  },
}
