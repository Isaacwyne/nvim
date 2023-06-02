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
