local present, lk = pcall(require, 'lspkind')
if not present then
  return
end

lk.init({
  mode = 'symbol_text',
  preset = 'codicons',
  symbol_map = {
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    EnumMember = " ",
    Enum = "",
    Event = "",
    Field = "󰜢",
    Folder = " ",
    Function = "󰊕 ",
    Interface = "",
    Method = "󰆧",
    Module = "",
    Property = "󰜢",
    Snippet = "",
    Struct = " ",
    Text = "󰉿",
    Unit = " ",
    Value = "󰎠",
    Variable = "󰀫",
    Keyword = "󰌋",
    File = "󰈙",
    Reference = "󰈇",
    Operator = "󰆕",
    TypeParameter = "",
  },
})

local present1, cmp = pcall(require, 'cmp')
if not present1 then
  return
end
local status, luasnip = pcall(require, 'luasnip')
if not status then
  return
end
require('luasnip.loaders.from_vscode').lazy_load()

local function has_words_before()
  local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  duplicates = {
    nvim_lsp = 1,
    luasnip = 1,
    cmp_tabnine = 1,
    buffer = 1,
    path = 1,
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ['<C-e>'] = cmp.mapping { i =  cmp.mapping.abort(), c = cmp.mapping.close() },
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function (fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function (fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" })
  }),
  sources = cmp.config.sources({
    { name = "gh_issues" },
    { name = "nvim_lua" },
    { name = 'nvim_lsp', priority = 1000 },
    { name = "path", priority = 250 },
    { name = "luasnip", priority = 750 },
    { name = "buffer", priority = 500, keyword_length = 5 },
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = require("lspkind").cmp_format({
      with_text = true,
      mode = "symbol_text",
      maxwidth = 50,
      ellipsis_char = '...',
    })
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})
