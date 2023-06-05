local present, bufferline = pcall(require, "bufferline")

if not present then
  return
end

local opts = {
  options = {
    always_show_bufferline = true,
    buffer_close_icon = '󰅖',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(_, _, diag)
      local icons = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
      }
      local ret = (diag.error and icons.Error .. diag.error .. " " or "")
      .. (diag.warning and icons.Warn .. diag.warning or "")
      return vim.trim(ret)
    end,
    offsets = {
      {
        filetype = "neo-tree",
        text = "Neo-tree",
        highlight = "Directory",
        text_align = "left",
      },
    },
  },
}

bufferline.setup(opts)
