local header = function()
  local banner_small = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
  }
  return banner_small
end

-- footer
local footer = function()
  local version = vim.version()
  local print_version = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
  local datetime = os.date "%d/%m/%Y %H:%M"

  return {
    " ",
    print_version .. " - " .. datetime,
  }
end

local present, alpha = pcall(require, "alpha")
local ok, dashboard = pcall(require, "alpha.themes.dashboard")
if not present and ok then
  return
end

dashboard.section.header.val = header()

dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
  dashboard.button("f", "  Find files", "<cmd>Telescope find_files<CR>"),
  dashboard.button("g", "󰊄  Find text", "<cmd>Telescope live_grep<CR>"),
  dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
  dashboard.button("o", "󰔠  Recent files", "<cmd>Telescope oldfiles<CR>"),
  dashboard.button("p", "  Plugins", "<cmd>Lazy<CR>"),
  dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
}
for _, button in ipairs(dashboard.section.buttons.val) do
  button.opts.hl = "AlphaButtons"
  button.opts.hl_shortcut = "AlphaShortcut"
end
dashboard.section.header.opts.hl = "Number"
dashboard.section.buttons.opts.hl = "AlphaButtons"
dashboard.section.footer.opts.hl = "Function"
dashboard.opts.layout[1].val = 8

-- close lazy and re-open when the dashboard is ready
if vim.o.filetype == "lazy" then
  vim.cmd.close()
  vim.api.nvim_create_autocmd("User", {
    pattern = "AlphaReady",
    callback = function()
      require("lazy").show()
    end,
  })
end

alpha.setup(dashboard.config)

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
    pcall(vim.cmd.AlphaRedraw)
  end,
})
