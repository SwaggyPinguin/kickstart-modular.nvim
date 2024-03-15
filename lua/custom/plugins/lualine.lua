return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require 'lualine'
    local lazy_status = require 'lazy.status'

    lualine.setup {
      options = {
        -- theme = 'gruvbox',
        theme = 'gruvbox-material',
      },
      sections = {
        lualine_x = {
          { lazy_status.updates, cond = lazy_status.has_updates, color = { fg = '#ff9e64' } },
          { 'encoding' },
          { 'filetype' },
          { 'filesize' },
        },
      },
    }
  end,
}
