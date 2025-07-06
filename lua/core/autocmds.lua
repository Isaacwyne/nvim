-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- don't auto comment newlines
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('disableAutoComment', { clear = true }),
  command = 'set formatoptions-=c formatoptions-=r formatoptions-=0',
})

-- go to the last location when opening a buffer {{{
vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('last_loc', { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q> {{{
vim.api.nvim_create_autocmd('Filetype', {
  group = vim.api.nvim_create_augroup('close_with_q', { clear = true }),
  callback = function(event)
    local filetype = vim.api.nvim_get_option_value('filetype', { buf = event.buf })
    local buftype = vim.api.nvim_get_option_value('buftype', { buf = event.buf })
    if buftype == 'nofile' or filetype == 'help' then
      vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true, nowait = true })
    end
  end,
})
