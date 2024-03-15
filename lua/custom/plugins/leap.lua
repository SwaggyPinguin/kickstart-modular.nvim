return {
  'ggandor/leap.nvim',
  opts = {
    safe_labels = {}, -- disabel auto jump to the first label
  },
  -- init = function()
  --   -- require('leap').create_default_mappings() -- creates the following mappings:
  --   vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)')
  --   vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)')
  --   vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-from-window)')
  -- end,
  keys = {
    { 's', '<Plug>(leap-forward)', { mode = { 'n', 'x', 'o' }, desc = 'Leap forward' } },
    { 'S', '<Plug>(leap-backward)', { mode = { 'n', 'x', 'o' }, desc = 'Leap backward' } },
    { 'gs', '<Plug>(leap-from-window)', { mode = { 'n', 'x', 'o' }, desc = 'Leap from window' } },
  },
}
