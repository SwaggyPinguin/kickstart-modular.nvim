return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    opts = {},
    config = function()
      require('copilot').setup {
        panel = {
          auto_refresh = false,
          keymap = {
            accept = '<CR>',
            jump_prev = '[[',
            jump_next = ']]',
            refresh = 'gr',
            open = '<M-CR>',
          },
        },
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = '<M-j>',
            prev = '<M-[>',
            next = '<M-]>',
            dismiss = '<C-]>',
          },
        },
      }
    end,
  },
}
