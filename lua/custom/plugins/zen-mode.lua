return {
  'folke/zen-mode.nvim',
  lazy = true,
  opts = {
    plugins = {
      gitsigns = { enabled = true },
      tmux = { enabled = false }, -- add this to tmux.conf -> set-option -g allow-passthrough on
      twilight = { enabled = true },
    },
  },
  -- init = function()
  --   -- vim.keymap.set('n', '<leader>z', ':ZenMode<CR>', { silent = true, desc = '[Z]en Mode' })
  -- end,
  keys = {
    {
      '<leader>z',
      function()
        require('zen-mode').toggle {
          window = {
            width = 0.80, -- width will be XX% of the editor screen
          },
        }
      end,
      desc = '[Z]en Mode',
    },
  },
}
