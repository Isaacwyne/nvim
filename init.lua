for _, source in ipairs({
  "core.options",
  "core.autocmds",
  "core.plugins",
}) do
  local present, fault = pcall(require, source)
  if not present then
    vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
  end
end
