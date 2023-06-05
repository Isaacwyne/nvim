-- functional wrapper for mapping custom keybindings
local map = function (mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_deep_extend("force", options, opts or {})
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- better up/down navigation
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

map("n", "x", '"_x')
map("n", "<leader>x", "<cmd>bdelete<cr>", { desc = "Close current buffer" })
-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })

-- copy & paste to from system clipboard ('+' register)
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to '+' register" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank line to '+' register" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete text to the black hole" })

-- select all
map("n", "<leader>a", "gg<S-v>G", { desc = "Select all" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half a page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half a page up" })

-- neotree
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neotree" })
map("n", "<leader>o", function ()
  if vim.bo.filetype == "neo-tree" then
    vim.cmd.wincmd "p"
  else
    vim.cmd.Neotree "focus"
  end
end, { desc = "Focus Neotree" })
map("n", "<leader>bb",
  "<cmd>Neotree buffers right toggle<cr>",
  { desc = "Show open buffers" }
)

-- better indenting (without leaving visual mode)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>-", "<C-W>s", { desc = "Split below" })
map("n", "<leader>\\", "<C-W>v", { desc = "Split right" })

-- telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files", silent = true })
map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>", { desc = "Find all files", silent = true })
map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Live grep", silent = true })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers", silent = true })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help pages", silent = true })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Find oldfiles", silent = true })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find in current buffer", silent = true })
-- using telescope with git
map("n", "<leader>cm", "<cmd>Telescope git_commits <cr>", { desc = "Git commit", silent = true })
map("n", "<leader>gt", "<cmd>Telescope git status<cr>", { desc = "Git status", silent = true })

-- buffer navigation
map("n", "]b", "<cmd>bprevious<cr>", { desc = "Previous buffer", silent = true })
map("n", "[b", "<cmd>bnext<cr>", { desc = "Next buffer", silent = true })

-- lspsaga keymaps
