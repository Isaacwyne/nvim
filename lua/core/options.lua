vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

local options = {
  conceallevel = 3,
  cursorline = true,
  formatoptions = "jcroqlnt",
  hlsearch = false,
  laststatus = 0,
  showmode = true,
  winminwidth = 5,
  wrap = false,

  title = true,

  -- highlights
  termguicolors = true,

  -- indenting
  breakindent = true,
  cindent = true,
  expandtab = true,
  linebreak = true,
  shiftround = true,
  shiftwidth = 4,
  smartindent = true,
  softtabstop = 4,
  tabstop = 4,

  belloff = "all",
  hidden = true,
  ignorecase = true,
  mouse = "i",
  smartcase = true,
  swapfile = false,

  -- Number
  number = true,
  numberwidth = 2,
  relativenumber = true,
  ruler = false,

  matchtime = 2,
  scrolloff = 8,
  -- showmatch = true,
  sidescrolloff = 10,
  signcolumn = "auto",
  splitbelow = true,
  splitright = true,
  timeoutlen = 400,
  undofile = true,
  undolevels = 10000,
  updatetime = 200,

  list = true,
  shell = "bash",
  spelllang = { "en" },

  -- cool floating window popup menu for completion on the commandline
  pumblend = 10,
  pumheight = 10,
  wildmode = "longest:full,full",       -- commandline completion mode
  wildoptions = "pum",
}
for k, v in pairs(options) do
  opt[k] = v
end

-- opt.completeopt = "menu,menuone,noselect"

if vim.fn.executable("rg") then
  -- if ripgrep is installed, use that as grepper
  opt.grepprg = "rg --vimgrep --no-heading"
  opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

local default_providers = {
  "node",
  "perl",
  "python3",
  "ruby",
}
for _, provider in ipairs(default_providers) do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end

local default_plugins = {
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "matchit",
  "matchparen",
  "logiPat",
  "rrhelper",
}
for _, plugin in pairs(default_plugins) do
  vim.g["loaded_" .. plugin] = 1
end

-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0
