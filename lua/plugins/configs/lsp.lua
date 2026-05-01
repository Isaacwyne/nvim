return {
  -- `lazydev` configures Lua LSP for neovim, runtime and plugins
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },

    -- main LSP configuration
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        { 'mason-org/mason.nvim', opts = {} },
        'mason-org/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        -- allows extra capabilities provided by blink.cmp
        'saghen/blink.cmp',
      },

      config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
          callback = function(event)
            local map = function(keys, func, desc, mode)
              mode = mode or 'n'
              vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP ' .. desc })
            end

            map('grn', vim.lsp.buf.rename, 'Rename')
            map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
            map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          end,
        })

        -- Diagnostic config
        local diagnostic_signs = {
          Error = '󰅚 ',
          Warn = '󰀪 ',
          Hint = '󰋽 ',
          Info = '󰌶 ',
        }

        vim.diagnostic.config {
          virtual_text = { prefix = '●', spacing = 4 },
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
              [vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
              [vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
              [vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
            },
          },
          underline = true,
          update_in_insert = false,
          severity_sort = true,
          float = {
            border = 'rounded',
            source = 'always',
            header = '',
            prefix = '',
            focusable = false,
            style = 'minimal',
          },
        }

        local capabilities = require('blink.cmp').get_lsp_capabilities()

        local servers = {
          lua_ls = {
            settings = {
              Lua = {
                completion = {
                  callSnippet = 'Replace',
                },
              },
            },
          },
        }

        -- Ensure the servers and tools above are installed
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
          'stylua',
        })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        require('mason-lspconfig').setup {
          ensure_installed = {},
          automatic_installation = false,
          handlers = {
            function(server_name)
              local server = server[server_name] or {}
              server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
              require('lspconfig')[server_name].setup(server)
            end,
          },
        }
      end,
    },

    { -- Autoformat
      'stevearc/conform.nvim',
      event = { 'BufWritePre' },
      cmd = { 'ComformInfo' },
      keys = {
        {
          '<leader>f',
          function()
            require('conform').format { async = true, lsp_format = 'fallback' }
          end,
          mode = '',
          desc = '[F]ormat buffer',
        },
      },
      opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
          -- disable "format_on_save lsp_fallback" for languages that don't
          -- have a well standardized coding style. You can add additional
          -- languages have or re-enable it for the disabled ones.
          local disable_filetypes = { c = true, cpp = true }
          if disable_filetypes[vim.bo[bufnr].filetype] then
            return nil
          else
            return {
              timeout_ms = 500,
              lsp_format = 'fallback',
            }
          end
        end,
        formatters_by_ft = {
          lua = { 'stylua' },
        },
      },
    },

    -- Autocompletion
    {
      'saghen/blink.cmp',
      event = 'VimEnter',
      version = '1.*',
      dependencies = {
        -- snippet engine
        {
          'L3MON4D3/LuaSnip',
          version = '2.*',
          dependencies = {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        'folke/lazydev.nvim',
      },

      --- @module 'blink.cmp'
      --- @type blink.cmp.config
      opts = {
        keymap = {
          preset = 'default',
        },
        appearance = {
          nerd_font_variant = 'mono',
        },
        completion = {
          documentation = { auto_show = false, auto_show_delay_ms = 500 },
        },

        sources = {
          default = { 'lsp', 'path', 'snippets', 'lazydev' },
          providers = {
            lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
          },
        },

        snippets = { preset = 'luasnip' },
        fuzzy = { implementation = 'lua' },
        signature = { enabled = true },
      },
    },
  },
}
