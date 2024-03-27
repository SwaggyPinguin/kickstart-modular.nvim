return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    {
      'f-person/git-blame.nvim',
      lazy = true,
      opts = true,
      init = function()
        -- This disables showing of the blame text next to the cursor
        vim.g.gitblame_display_virtual_text = 0
      end,
    },
  },
  config = function()
    local lualine = require 'lualine'
    local lazy_status = require 'lazy.status'
    local git_blame = require 'gitblame'

    lualine.setup {
      options = {
        theme = 'gruvbox-material',
        -- theme = 'gruvbox-flat',
        globalstatus = true,
        always_divide_middle = false,
        disabled_filetypes = { 'nvim-dap-ui' },
      },
      sections = {
        lualine_a = {
          --  
          { 'mode', icon = '' },
        },
        lualine_b = {
          { 'branch', icon = '' },
          { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' } },
          {
            'diagnostics',
            sources = { 'nvim_lsp' },
            symbols = { error = ' ', warn = ' ', info = ' ' },
            color_error = '#ff9e64',
            color_warn = '#ff9e64',
            color_info = '#ff9e64',
          },
        },
        lualine_c = {
          '%=',
          { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available, icon = '', separator = { left = ' ', right = ' ' } },
        },
        lualine_x = {
          { lazy_status.updates, cond = lazy_status.has_updates, color = { fg = '#ff9e64' } },
          { 'filetype' },
        },
        lualine_y = {
          {
            function()
              return vim.loop.cwd():match '([^/]+)$'
            end,
            icon = '',
            on_click = function()
              require('neo-tree.command').execute {}
            end,
          },
          -- { 'hostname', icon = '' },
        },
        lualine_z = {
          -- 
          { 'datetime', icon = '', style = '%H:%M' },
        },
      },
      extensions = { 'fugitive', 'neo-tree', 'trouble', 'lazy', 'mason', 'nvim-dap-ui', 'quickfix', 'toggleterm' },
    }
  end,
}
