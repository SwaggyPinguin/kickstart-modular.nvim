return {
  'hedyhli/outline.nvim',
  lazy = true,
  cmd = { 'Outline', 'OutlineOpen' },
  keys = {
    { '<leader>no', '<cmd>Outline<CR>', desc = '[N]eoTree [O]utline' },
  },
  opts = {
    keymaps = {
      up_and_jump = '<C-p>',
      down_and_jump = '<C-n>',
    },
  },
}
