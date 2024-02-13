local opt = vim.opt
local g = vim.g

local options = {
  laststatus = 3,       -- global statusline
  showmode = false,
  hlsearch = false,

  cursorline = true,

  -- Indenting
  breakindent = true,
  cindent = true,
  expandtab = true,
  shiftwidth = 4,
  smartindent = true,
  tabstop = 4,
  softtabstop = 4,

  fillchars = { eob = " " },
  ignorecase = true,
  smartcase = true,
  mouse = "nvi",
  wrap = false,

  -- numbers
  number = true,
  relativenumber = true,
  numberwidth = 2,
  ruler = false,

  scrolloff = 999,
  sidescrolloff = 999,
  signcolumn = "auto",
  splitbelow = true,
  splitright = true,
  termguicolors = true,
  timeoutlen = 400,
  undofile = true,
  writebackup = false,

  -- folds
  foldmethod = "marker",

  -- interval for writing swap file to disk, also used by gitsigns
  updatetime = 250,
}

for option, value in pairs(options) do
  vim.opt[option] = value
end
opt.shortmess:append "IsF"
-- go to previous/next line with h,l,left and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- add mason-installed binaries to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath "data" .. "/mason/bin"

if vim.fn.executable "rg" then
  -- if ripgrep is installed, use that as grepper
  opt.grepprg = "rg --vimgrep --no-heading"
  opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end
