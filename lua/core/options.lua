local opt = vim.opt
local g = vim.g

-------------------------------------- options ------------------------------------------
opt.laststatus = 3 -- global statusline
opt.cursorline = true
opt.showmode = false
opt.hlsearch = false

opt.cursorline = true

-- Indenting
opt.breakindent = true
opt.cindent = true
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "nvi"
opt.wrap = false

-- Numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

opt.scrolloff = 10
opt.sidescrolloff = 10
opt.signcolumn = "auto"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

g.mapleader = " "
g.maplocalleader = " "

-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath("data") .. "/mason/bin"

if vim.fn.executable("rg") then
  -- if ripgrep is installed, use that as grepper
  opt.grepprg = "rg --vimgrep --no-heading"
  opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end
