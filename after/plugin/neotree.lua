local present, neotree = pcall(require, "neo-tree")
if not present then
  return
end

neotree.setup({
  cmd = "Neotree",
  init = function()
    vim.g.neo_tree_remove_legacy_commands = true
  end,
  opts = {
    auto_clean_after_session_restore = true,
    close_if_last_window = true,
    sources = { "filesystem", "buffers", "git_status" },
    sources_selector = {
      winbar = true,
      content_layout = "center",
    },
    window = {
      width = 30,
      mappings = {
        ["<space>"] = false,
      },
    },
    filesystem = {
      follow_current_file = true,
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
    },
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function(_)
          vim.opt_local.signcolumn = "auto"
        end,
      },
    },
    default_component_configs = {
      indent = { padding = 0, indent_size = 1 },
    },
  },
})
