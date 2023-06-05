local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    section_separators = "",
    component_separators = "",
    disabled_filetypes = {
      statusline = {},
      winbar = {}
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000
    },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = { {
      'filename',
      file_status = true,      -- displays file status
      path = 0,                -- just filename
    } },
    lualine_x = {
      'diagnostics',
      'encoding',
      'fileformat',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { {
      'filename',
      file_status = true,
      path = 1                --- relative-path
    } },
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = { "fugitive" }
}
