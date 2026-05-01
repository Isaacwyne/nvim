vim.g.have_nerd_font = true

vim.o.laststatus = 3
vim.o.showmode = false
vim.o.hlsearch = false

vim.o.cursorline = true

-- indenting
vim.o.breakindent = true
vim.o.cindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wrap = false

-- numbering
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 2
vim.o.ruler = false

vim.o.scrolloff = 10
vim.o.sidescrolloff = 999
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.writebackup = false
vim.opt.iskeyword:append '-' -- include in keywords

-- interval for writing swap file to disk! Also used by Git
vim.o.updatetime = 250

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.confirm = true

vim.opt.whichwrap:append '<>[]hl'

for _, provider in ipairs { 'node', 'perl', 'python3', 'ruby' } do
  vim.g['loaded_' .. provider .. '_provider'] = 0
end

if vim.fn.executable 'rg' then
  -- if ripgrep is installed, use that as grepper
  vim.opt.grepprg = 'rg --vimgrep --no-heading'
  vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
end

vim.cmd [[ let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' ]]
