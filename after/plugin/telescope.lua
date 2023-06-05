local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

telescope.setup({
  defaults = {
    layout_config = {
      width = 0.95,
      height = 0.85,
    },
    horizontal = {
      preview_width = function(_, cols, _)
        if cols > 200 then
          return math.floor(cols * 0.4)
        else
          return math.floor(cols * 0.6)
        end
      end,
    },
    vertical = {
      width = 0.9,
      height = 0.95,
      preview_height = 0.5,
    },
    flex = {
      horizontal = {
        preview_width = 0.9,
      },
    },
    find_command = {
      "rg",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "$ ",
    selection_caret = " ",
    entry_prefix = " ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    file_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    file_ignore_patterns = {},
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" },
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,     -- false will only do exact matching
      override_generic_sorter = true,         -- override the generic sorter
      override_file_sorter = true,            -- override the file sorter
      case_mode = "smart_case",               -- or "ignore_case" or "respect_case"
    },
  },
  extensions_list = { "fzf" },
})

pcall(function ()
  for _, ext in ipairs(options.extensions_list) do
    telescope.load_extension(ext)
  end
end)
