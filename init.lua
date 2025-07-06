require 'core.options'
require 'core.keymaps'
require 'core.autocmds'
require 'plugins'

------- Transparent background ---------
-- Set the background of the Normal highlight group to transparent
vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })

-- Set the background of non-text elements to transparent
vim.api.nvim_set_hl(0, 'NonText', { bg = 'NONE' })

-- Optionally, set other highlight groups to transparent
vim.api.nvim_set_hl(0, 'LineNr', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'NONE' })
