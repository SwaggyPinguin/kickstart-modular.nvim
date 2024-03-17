-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following lua:
--    require('gitsigns').setup({ ... })
--
-- See `:help gitsigns` to understand what the configuration keys do
return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', 'ghn', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = '[G]it [H]unk [N]ext' })

        map('n', 'ghp', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = '[G]it [H]unk [P]revious' })

        -- Actions
        map('n', '<leader>ghs', gs.stage_hunk, { desc = '[G]it [H]unk [S]tage' })
        map('n', '<leader>ghr', gs.reset_hunk, { desc = '[G]it [H]unk [R]eset' })
        map('v', '<leader>ghs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[G]it [H]unk [S]tage' })
        map('v', '<leader>ghr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[G]it [H]unk [R]eset' })
        map('n', '<leader>ghS', gs.stage_buffer, { desc = '[G]it [H]unk [S]tage Buffer' })
        map('n', '<leader>ghu', gs.undo_stage_hunk, { desc = '[G]it [H]unk [U]ndo stage' })
        map('n', '<leader>ghR', gs.reset_buffer, { desc = '[G]it [H]unk [R]eset Buffer' })
        map('n', '<leader>ghp', gs.preview_hunk, { desc = '[G]it [H]unk [P]review' })
        map('n', '<leader>ghb', function()
          gs.blame_line { full = true }
        end, { desc = '[G]it [H]unk [B]lame' })
        map('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = '[G]it [T]oggle [B]lame' })
        map('n', '<leader>ghd', gs.diffthis, { desc = '[G]it [H]unk [D]iff' })
        map('n', '<leader>ghD', function()
          gs.diffthis '~'
        end, { desc = '[G]it [H]unk [D]iff ~' })
        map('n', '<leader>gtd', gs.toggle_deleted, { desc = '[G]it [T]oggle [D]eleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Gitsigns select hunk' })
      end,
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
