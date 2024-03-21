local options = {
  ensure_installed = {
    "bash",
    "c",
    "html",
    "javascript",
    "json",
    "lua",
    "luadoc",
    "luap",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "regex",
    "vim",
    "vimdoc",
    "yaml",
  },

  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
    disable = {},
  },
  autotag = {
    enable = true,
  },
  ts_context_commentstring = {
    enable = true,
  },
}

return options
