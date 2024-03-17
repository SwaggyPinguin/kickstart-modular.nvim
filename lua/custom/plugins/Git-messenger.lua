return {
  'rhysd/git-messenger.vim',
  lazy = true,
  cmd = 'GitMessenger',
  keys = {
    { '<leader>gm', '<Plug>(git-messenger)', desc = '[G]it Reveal commit [M]essage under cursor' },
  },
  init = function()
    vim.g.git_messenger_include_diff = 'current'
    vim.g.git_messenger_no_default_mappings = false
    vim.g.git_messenger_floating_win_opts = { border = 'rounded' }
  end,
}
