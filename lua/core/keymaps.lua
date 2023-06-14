local M = {}

M.general = {
  n = {
    -- better up/down navigation
    ["j"] = { "v:count == 0 ? 'gj' : 'j'", "Move up", opts = { expr = true } },
    ["k"] = { "v:count == 0 ? 'gk' : 'k'", "Move down", opts = { expr = true } },
    ["<leader>b"] = { "<cmd> enew<cr>", "New buffer" },

    -- buffer navigation
    ["[b"] = { "<cmd>bprev<cr>", "Goto previous buffer" },
    ["]b"] = { "<cmd>bnext<cr>", "Goto next buffer" },

    ["x"] = { '"_x' },
    ["<leader>x"] = { "<cmd> bdelete<cr>", "Close current buffer" },

    -- copy & paste to & from system clipboard ('+' register)
    ["<leader>y"] = { [["+y]], "Yank to system clipboard" },
    ["<leader>d"] = { [["_d]], "delete text to blackhole" },
    ["<leader>Y"] = { [["+Y]], "Yank line to system clipboard" },

    ["<leader>a"] = { "gg<S-v>G", "Select all" },
    ["<C-d>"] = { "<C-d>zz", "Half a page down" },
    ["<C-u"] = { "<C-u>zz", "Half a page up" },

    -- windows
    ["<leader>ww"] = { "<C-W>p", "Other window" },
    ["<leader>wd"] = { "<C-W>c", "Delete window" },
    ["<leader>-"] = { "<C-W>s", "Split below" },
    ["<leader>\\"] = { "<C-W>v", "Split right" },

    ["<leader>1"] = { "<cmd>lua require('bufferline').go_to(1, true)<cr>"},
    ["<leader>2"] = { "<cmd>lua require('bufferline').go_to(2, true)<cr>"},
    ["<leader>3"] = { "<cmd>lua require('bufferline').go_to(3, true)<cr>"},
    ["<leader>4"] = { "<cmd>lua require('bufferline').go_to(4, true)<cr>"},
    ["<leader>5"] = { "<cmd>lua require('bufferline').go_to(5, true)<cr>"},
    ["<leader>6"] = { "<cmd>lua require('bufferline').go_to(6, true)<cr>"},
    ["<leader>7"] = { "<cmd>lua require('bufferline').go_to(7, true)<cr>"},
    ["<leader>8"] = { "<cmd>lua require('bufferline').go_to(8, true)<cr>"},
    ["<leader>9"] = { "<cmd>lua require('bufferline').go_to(9, true)<cr>"},
  },

  v = {
    ["<leader>y"] = { [["+y]], "Yank to system clipboard" },
    ["<leader>d"] = { [["_d]], "delete text to blackhole" },

    -- better indenting (without leaving visual mode)
    ["<"] = { "<gv" },
    [">"] = { ">gv" },
  },
}

M.lspconfig = {
  plugin = true,

  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    ["<leader>ra"] = {
      function()
        vim.lsp.buf.rename()
      end,
      "LSP rename",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "LSP references",
    },

    ["<leader>f"] = {
      function()
        vim.diagnostic.open_float({ border = "rounded" })
      end,
      "Floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "Goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "Goto next",
    },

    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "Diagnostic setloclist",
    },

    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format({ async = true })
      end,
      "LSP formatting",
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<leader>e"] = { "<cmd> NvimTreeToggle<cr>", "Toggle nvimtree" },
    -- focus
    ["<leader>o"] = { "<cmd> NvimTreeFocus<cr>", "Focus nvimtree" },
  },
}
M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <cr>", "Find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <cr>", "Find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <cr>", "Live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <cr>", "Find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags<cr>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles<cr>", "Find oldfiles" },
    ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find<cr>", "Find in current buffer" },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits<cr>", "Git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status<cr>", "Git status" },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
      "Toggle block comment",
    },
  },
}

M.whichkey = {
  plugin = true,

  n = {
    ["<leader>wK"] = {
      function()
        vim.cmd("WhichKey")
      end,
      "Which-key all keymaps",
    },
    ["<leader>wk"] = {
      function()
        local input = vim.fn.input("WhichKey: ")
        vim.cmd("WhichKey " .. input)
      end,
      "Which-key query lookup",
    },
  },
}

M.blankline = {
  plugin = true,

  n = {
    ["<leader>cc"] = {
      function()
        local ok, start = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
          vim.cmd([[normal! _]])
        end
      end,

      "Jump to current context",
    },
  },
}

M.gitsigns = {
  plugin = true,

  n = {
    -- Navigation through hunks
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },

    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },

    -- Actions
    ["<leader>rh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },

    ["<leader>ph"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },

    ["<leader>gb"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Blame line",
    },

    ["<leader>td"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
  },
}

return M
