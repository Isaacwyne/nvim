local M = {}
local utils = require "core.utils"

local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then
      return ""
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
    end
    return str
  end
end

M.colorscheme = {
  style = "darker",
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
    darker = true,
    undercurl = true,
    background = true,
  },

  -- lualine options
  lualine = {
    transparent = true,
  },
}

M.blankline = {
  indentLine_enabled = 1,
  filetype_exclude = {
    "TelescopePrompt",
    "TelescopeResults",
    "help",
    "lazy",
    "lazyterm",
    "lspinfo",
    "mason",
    "alpha",
    "terminal",
    "man",
    "",
  },
  buftype_exclude = { "terminal" },
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  show_current_context = true,
  show_current_context_start = true,
}

M.bufferline = {
  options = {
    themable = true,
    offsets = {
      { filetype = "NvimTree", highlight = "NvimTreeNormal" },
    },
  },
}

M.gitsigns = {
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "│" },
    topdelete = { text = "│" },
    changedelete = { text = "│" },
    untracked = { text = "┆" },
  },
  on_attach = function(bufnr)
    utils.load_mappings("gitsigns", { buffer = bufnr })
  end,

  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,

  watch_gitdir = {
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false,

  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  max_file_length = 40000,

  preview_config = {
    -- options passed to neovim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
}

M.statusline = {
  options = {
    icons_enabled = true,
    theme = "auto",
    section_separators = "",
    component_separators = "",
    disabled_filetypes = {
      statusline = {
        "alpha",
        "dashboard",
        "man",
        "netrw",
        "veil",
      },
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = {
      { "mode", fmt = trunc(80, 4, nil, true) },
    },
    lualine_b = { "branch" },
    lualine_c = {
      {
        "filename",
        fmt = trunc(90, 30, 50, true),
        filestatus = true,
        path = 0,
      },
    },
    lualine_x = {
      "diagnostics",
      "encoding",
      "fileformat",
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        "filename",
        file_status = true,
        path = 1,       -- relative path
      },
    },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = { "nvim-tree", "lazy" },
}

M.noice = {
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      view = "mini",
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = true,
  },
}

return M
