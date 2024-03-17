return {
  'FabijanZulj/blame.nvim',
  cmd = 'ToggleBlame',
  lazy = true,
  keys = {
    { '<leader>gb', ':ToggleBlame virtual<CR>', desc = '[G]it [B]lame' },
    { '<leader>gB', ':ToggleBlame window<CR>', desc = '[G]it [B]lame (window)' },
  },
  opts = {
    date_format = '%Y-%m-%d %H:%M',
  },
}
