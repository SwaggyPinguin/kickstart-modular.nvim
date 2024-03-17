return {
  'chrisgrieser/nvim-spider',
  lazy = true,
  opts = {
    skipInsignificantPunctiation = true,
    subwordMovement = false,
    customPatterns = {},
  },
  init = function()
    local map = function(key)
      vim.keymap.set({ 'n', 'o', 'x' }, key, ":lua require('spider').motion('" .. key .. "')<CR>", { silent = true })
    end

    map 'w'
    map 'e'
    map 'b'

    -- remap the default keys for visual mode
    vim.keymap.set('v', 'w', 'w', { silent = true })
    vim.keymap.set('v', 'e', 'e', { silent = true })
    vim.keymap.set('v', 'b', 'b', { silent = true })
  end,
  -- keys =
  --   { 'w', ":lua require('spider').motion('w') <CR>", { mode = { 'n', 'o', 'x' }, silent = true, desc = 'Move to start of next word' } },
  --   { 'e', ":lua require('spider').motion('e') <CR>", { mode = { 'n', 'o', 'x' }, silent = true, desc = 'Move to end of word' } },
  --   { 'b', ":lua require('spider').motion('b') <CR>", { mode = { 'n', 'o', 'x' }, silent = true, desc = 'Move to start of previous word' } },
  -- },
}
