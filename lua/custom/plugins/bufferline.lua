return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'famiu/bufdelete.nvim',
  },
  opts = {
    options = {
      mode = 'buffers',
      numbers = 'none',
      sort_by = 'directory',
      middle_mouse_command = 'Bdelete! %d',
      right_mouse_command = nil,
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'File Explorer',
          text_align = 'center',
        },
      },
    },
  },
  init = function()
    vim.opt.termguicolors = true

    local opts = { noremap = true, silent = true }

    local map = function(mode, lhs, rhs, options, additional_options)
      vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', options, additional_options or {}))
    end

    -- Tab/Buffers navigation
    map('n', '<A-,>', ':tabnext<CR>', opts, { desc = '[T]ab Next' })
    map('n', '<A-.>', ':tabprevious<CR>', opts, { desc = '[T]ab Previous' })
    map('n', '<A-c>', ':tabclose<CR>', opts, { desc = '[T]ab Close' })

    map('n', '<tab>', ':BufferLineCycleNext<CR>', opts, { desc = '[B]uffer Next' })
    map('n', '<S-tab>', ':BufferLineCyclePrev<CR>', opts, { desc = '[B]uffer Previous' })

    map('n', '<A->>', ':BufferLineMoveNext<CR>', opts, { desc = '[B]uffer Move Next' })
    map('n', '<A-<>', ':BufferLineMovePrev<CR>', opts, { desc = '[B]uffer Move Previous' })

    -- map('n', '<leader>bgt', ':BufferLineGroupToggle<CR>', opts, { desc = { '[B]uffer [G]roup [T]oggle' } })
    -- map('n', '<leader>bgc', ':BufferLineGroupClose<CR>', opts, { desc = { '[B]uffer [G]roup [T]oggle' } })

    map('n', '<leader>bsd', ':BufferLineSortByDirectory<CR>', opts, { desc = '[B]uffer [S]ort by [D]irectory' })
    map('n', '<leader>bse', ':BufferLineSortByExtension<CR>', opts, { desc = '[B]uffer [S]ort by [E]xtension' })
    map('n', '<leader>bst', ':BufferLineSortByTabs<CR>', opts, { desc = '[B]uffer [S]ort by [T]abs' })

    map('n', '<leader>br', ':BufferLineTabRename', {}, { desc = '[B]uffer [R]ename' })
    map('n', '<leader>bd', ':Bdelete<CR>', opts, { desc = '[B]uffer [D]elete' })
    map('n', '<leader>bp', ':BufferLineTogglePin<CR>', opts, { desc = '[B]uffer Toggle [P]in' })

    map('n', '<C-p>', ':BufferLinePick<CR>', opts, { desc = '[B]uffer [P]ick' })

    require 'custom.utils.bufferline.tabconfig'
  end,
}
