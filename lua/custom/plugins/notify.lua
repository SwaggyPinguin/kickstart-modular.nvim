return {
  'rcarriga/nvim-notify',
  lazy = true,
  keys = {
    {
      '<leader>ud',
      function()
        require('notify').dismiss { silent = true, pending = true }
      end,
      desc = '[U]I [D]ismiss all Notifications',
    },
  },
  config = function()
    require('notify').setup {
      stages = 'fade',
      timeout = 5000,
      background_colour = '#000000',
      icons = {
        ERROR = '',
        WARN = '',
        INFO = '',
        DEBUG = '',
        TRACE = '',
      },
    }
  end,
  opts = {
    timeout = 3000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { zindex = 100 })
    end,
  },
}
