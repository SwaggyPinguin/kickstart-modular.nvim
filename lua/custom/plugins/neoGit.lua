return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration

    -- Only one of these is needed, not both.
    'nvim-telescope/telescope.nvim', -- optional
    -- "ibhagwan/fzf-lua",              -- optional
  },
  config = {},
  init = function()
    local neogit = require 'neogit'

    vim.keymap.set('n', '<leader>gg', neogit.open, { silent = true, desc = '[G]it Neo[G]it' }) -- opens in a new tab
    -- vim.keymap.set('n', '<leader>gnf', neogit.open { kind = 'floating' }, { silent = true, desc = '[G]it [N]eogit [F]loating' })
  end,
}
