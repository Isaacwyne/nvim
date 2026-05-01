require 'core.options'
require 'core.keymaps'
require 'core.autocmds'
require 'plugins'

vim.cmd.colorscheme 'habamax'
------- Transparent background ---------
local function set_transparent()
  local groups = {
    'Normal',
    'NormalNC',
    'EndOfBuffer',
    'NormalFloat',
    'SignColumn',
    'StatusLine',
    'StatusLineNC',
    'TabLine',
    'TabLineFill',
    'TabLineSel',
    'ColorColumn',
  }
  for _, g in ipairs(groups) do
    vim.api.nvim_set_hl(0, g, { bg = 'none' })
  end
  vim.api.nvim_set_hl(0, 'TabLineFill', { bg = 'none', fg = '#767676' })
end

set_transparent()
