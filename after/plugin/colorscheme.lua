local present, onedark = pcall(require, "onedark")
if not present then
  return
end

onedark.setup {
  -- main options
  style = "dark",
  transparent = true,
  term_colors = true,
  ending_tildes = false,
  cmp_itemkind_reverse = false,

  code_style = {
    comments = "italic",
    keywords = "none",
    functions = "bold",
    strings = "none",
    variables = "italic",
  },

  -- plugins config
  diagnostics = {
    darker = true,              -- darker colors for diagnostics
    undercurl = true,           -- use undercurl instead of underline for diagnostics
    background = true,          -- use background color for virtual text
  },

  -- lualine options
  lualine = {
    transparent = true,
  },
}

onedark.load()
