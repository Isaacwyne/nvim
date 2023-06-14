local autocmd = vim.api.nvim_create_autocmd

local augroup = function(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- check if we need to reload the file when it's changed {{{
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})
-- }}}

-- resize splits if window got resized {{{
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
-- }}}

-- highlight on yank {{{
autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- }}}

-- don't auto comment newlines {{{
autocmd("BufEnter", {
  group = augroup("auto_comment"),
  command = "set fo-=c fo-=r fo-=o",
})
-- }}}

-- auto-remove trailing whitespace {{{
autocmd("BufWritePre", {
  group = augroup("whitespace"),
  command = "%s/\\s\\+$//e",
})
-- }}}

-- go to the last location when opening a buffer {{{
autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
-- }}}

-- close some filetypes with <q> {{{
autocmd("Filetype", {
  group = augroup("close_with_q"),
  callback = function(event)
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = event.buf })
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = event.buf })
    if buftype == "nofile" or filetype == "help" then
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, nowait = true })
    end
  end,
})
-- }}}

-- wrap and check for spell in text filetype {{{
autocmd("Filetype", {
  group = augroup("wrap_spell"),
  pattern = {
    "text",
    "gitcommit",
    "markdown",
  },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
-- }}}

-- terminal options {{{
autocmd("TermOpen", {
  group = augroup("terminal_opts"),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})
-- }}}

autocmd("FileType", {
  desc = "Unlist quickfist buffers",
  group = augroup("unlist_quickfist"),
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})
