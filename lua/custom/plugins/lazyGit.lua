return {
  'kdheepak/lazygit.nvim',
  lazy = true,
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  -- optional for floating window border decoration
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  init = function()
    vim.keymap.set('n', '<leader>gl', '<cmd>LazyGit<CR>', { desc = '[G]it [L]azyGit' })
    -- vim.keymap.set('n', '<leader>gc', '<cmd>LazyGitConfig<CR>', { desc = '[G]it LazyGit [C]onfig' })
    -- vim.keymap.set('n', '<leader>gf', '<cmd>LazyGitCurrentFile<CR>', { desc = '[G]it LazyGit [F]ile' })
    -- vim.keymap.set('n', '<leader>gF', '<cmd>LazyGitFilter<CR>', { desc = '[G]it LazyGit [F]ilter' })
    -- vim.keymap.set('n', '<leader>gC', '<cmd>LazyGitFilterCurrentFile<CR>', { desc = '[G]it LazyGit [C]urrent [F]ile' })

    vim.keymap.set('n', '<leader>gr', function()
      require('telescope').extensions.lazygit.lazygit()
    end, { desc = '[G]it LazyGit [R]epositories' })
  end,
}
-- vim: ts=2 sts=2 sw=2 et
