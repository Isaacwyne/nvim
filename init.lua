local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

for _, source in ipairs {
  "core.options",
  "core.autocmds",
  "core.keymaps",
  "plugins",
} do
  local present, fault = pcall(load, source)
  if not present then
    vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
  end
end

require("core.utils").load_mappings "general"

vim.cmd [[ hi def link LazyNormal Normal ]]
