return {
  'folke/trouble.nvim',
  lazy = true,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {},
  -- stylua: ignore
  keys = {
    { '<leader>xx', function() require('trouble').toggle() end, desc = 'Toggle Diagnostics' },
    { '<leader>xw', function() require('trouble').toggle 'workspace_diagnostics' end, desc = 'Toggle Workspace Diagnostics' },
    { '<leader>xd', function() require('trouble').toggle 'document_diagnostics' end, desc = 'Toggle Document Diagnostics' },
    { '<leader>xq', function() require('trouble').toggle 'quickfix' end, desc = 'Toggle Quickfix' },
    { '<leader>xl', function() require('trouble').toggle 'loclist' end, desc = 'Toggle Location List' },
    { '<leader>xR', function() require('trouble').toggle 'lsp_references' end, desc = 'Toggle LSP References' },
    { '<leader>xD', function() require('trouble').toggle 'lsp_definitions' end, desc = 'Toggle LSP Definitions' },
    { '<leader>xT', function() require('trouble').toggle 'lsp_type_definitions' end, desc = 'Toggle LSP Type Definitions' },
    { '<leader>xn', function() require('trouble').next { skip_groups = true, jump = true } end, desc = 'Jump to next Item' },
    { '<leader>xp', function() require('trouble').previous { skip_groups = true, jump = true } end, desc = 'Jump to previous Item' },
  },
}
