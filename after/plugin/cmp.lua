local present, cmp = pcall(require, 'cmp')
if not present then
  return
end
local status, luasnip = pcall(require, 'luasnip')
if not status then
  return
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "gh_issues" },
    { name = "nvim_lua" },
    { name = 'nvim_lsp' },
    { name = "path" },
    { name = "luasnip" },
    { name = "buffer", keyword_length = 5 },
  }),
  formatting = {
    format = require("lspkind").cmp_format({
      mode = "symbol_text",
      maxwidth = 50,
      ellipsis_char = '...',
    })
  },
})
