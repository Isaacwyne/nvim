local present, treesitter = pcall(require, "nvim-treesitter.configs")
if not present then
  return
end

local status, autotag = pcall(require, "nvim-ts-autotag")
if not status then
  return
end
autotag.setup({})

local opts = {
  ensure_installed = {
    "javascript",
    "c",
    "lua",
    "python",
    "rust",
    "vim",
  },
  autotag = {
    enable = true,
    filetypes = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "tsx", "jsx" },
  },

  highlight = {
    enable = true,
    disable = { "help" },
  },
  indent = {
    enable = true
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<M-w>",
      node_incremental = "<M-w>",     -- increment to the upper named parent
      node_decremental = "<M-C-w>",   -- decrement to the previous node
      scope_incremental = "<M-e>",
    },
  },
}

treesitter.setup(opts)
