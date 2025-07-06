vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- general
vim.keymap.set('n', '<leader>x', '<cmd> bdelete<cr>', { desc = 'close current buffer' })
vim.keymap.set('n', '<leader>pv', '<cmd> Ex<cr>', { desc = 'Open File Explorer' })
vim.keymap.set('n', '[b', '<cmd>bprev<cr>', { desc = 'goto previous buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'goto next buffer' })
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
