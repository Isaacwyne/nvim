local present, lspconfig = pcall(require, "lspconfig")
if (not present) then
  return
end

local on_attach_callback = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  local keymap = vim.keymap.set

  keymap("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP definition" })
  keymap("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover" })
  keymap("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP code action" })
  keymap("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP declaration" })
  keymap("n", "gT", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "LSP definition type" })
  keymap("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "LSP implementation" })
  keymap("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "LSP references" })
  keymap("n", "dn", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Goto next diagnostic" })
  keymap("n", "dp", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Goto previous diagnostic" })
  keymap("n", "<leader>r", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
  keymap("n", "gl", vim.diagnostic.open_float, { buffer = bufnr, desc = "Line diagnostics" })
  keymap("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = true })
  end, { buffer = bufnr, desc = "LSP formatting" })

  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local signs = {
  Error = '✘',
  Warn = '',
  Hint = '',
  Info = ''
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local border = {
  { '╭', 'FloatBorder' },

  { '─', 'FloatBorder' },

  { '╮', 'FloatBorder' },

  { '│', 'FloatBorder' },

  { '╯', 'FloatBorder' },

  { '─', 'FloatBorder' },

  { '╰', 'FloatBorder' },

  { '│', 'FloatBorder' },
}

-- LSP settings (for overriding per client)
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

require("mason").setup({
  ui = {
    icons = {
      package_pending = " ",
      package_installed = "󰄳 ",
      package_uninstalled = " 󰚌",
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },
})
require("mason-lspconfig").setup {
  ensure_installed = {
    "lua_ls",
    "bashls",
    -- "pylsp",
  },
  automatic_installation = true
}

lspconfig.lua_ls.setup {
  on_attach = on_attach_callback,
  capabilities = capabilities,
  handlers = handlers,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}
