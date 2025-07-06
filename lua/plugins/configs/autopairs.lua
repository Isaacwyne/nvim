return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      fast_wrap = {},
      disable_filetype = { 'TelescopePrompt', 'vim' },
    },
    config = function(_, opts)
      local npairs = require 'nvim-autopairs'
      npairs.setup(opts)
    end,
  },
}
