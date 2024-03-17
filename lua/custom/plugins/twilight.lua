return {
  'folke/twilight.nvim',
  lazy = true,
  opts = {},
  keys = {
    { '<leader>dtt', ':Twilight<CR>', desc = '[D]ocument [T]wilight [T]oggle' },
    { '<leader>dte', ':TwilightEnable<CR>', desc = '[D]ocument [T]wilight [E]nable' },
    { '<leader>dtd', ':TwilightDisable<CR>', desc = '[D]ocument [T]wilight [D]isable' },
  },
}
