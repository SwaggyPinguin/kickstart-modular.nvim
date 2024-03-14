return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    cmd = 'Neotree',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      {
        's1n7ax/nvim-window-picker',
        config = function()
          require('window-picker').setup()
        end,
      },
    },
    keys = {
      {
        '<leader>nr',
        function()
          require('neo-tree.command').execute {
            toggle = true,
            dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
            position = 'left',
          }
        end,
        desc = '[N]eoTree [R]oot',
      },
      {
        '<leader>nc', -- same as <C-e>
        function()
          require('neo-tree.command').execute { toggle = true, dir = vim.loop.cwd(), position = 'left' }
        end,
        desc = '[N]eoTree [C]urrent',
      },
      {
        '<leader>nf',
        function()
          require('neo-tree.command').execute { source = 'filesystem', toggle = true, reveal = true, position = 'float' }
        end,
        desc = '[N]eoTree [F]loating (filesystem)',
      },
      {
        '<leader>ns',
        function()
          require('neo-tree.command').execute { source = 'document_symbols', toggle = true, position = 'left' }
        end,
        desc = '[N]eoTree [S]ymbols',
      },
      -- { '<leader>e', '<leader>fe', desc = 'Explorer NeoTree (root dir)', remap = true },
      -- { '<leader>E', '<leader>fE', desc = 'Explorer NeoTree (cwd)', remap = true },
      {
        '<leader>ng',
        function()
          require('neo-tree.command').execute { source = 'git_status', toggle = true, position = 'float' }
        end,
        desc = '[N]eoTree [G]it',
      },
      {
        '<leader>nb',
        function()
          require('neo-tree.command').execute { source = 'buffers', toggle = true, position = 'left' }
        end,
        desc = '[N]eoTree [B]uffer',
      },
      {
        '<C-e>',
        function()
          require('neo-tree.command').execute { source = 'filesystem', toggle = true, reveal = true, position = 'left' }
        end,
        desc = 'Open NeoTree on current file',
      },
    },
    deactivate = function()
      vim.cmd [[Neotree close]]
    end,
    init = function()
      if vim.fn.argc(-1) == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == 'directory' then
          require 'neo-tree'
        end
      end
    end,
    opts = {
      sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
      source_selector = {
        winbar = true,
        statusline = false,
      },
      open_files_do_not_replace_types = { 'terminal', 'Trouble', 'trouble', 'qf', 'Outline' },
      close_if_last_window = true,
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ['<space>'] = 'none',
          ['Y'] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg('+', path, 'c')
            end,
            desc = 'copy path to clipboard',
          },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
      },
    },
    config = function(_, opts)
      require('neo-tree').setup(opts)

      vim.api.nvim_create_autocmd('TermClose', {
        pattern = '*lazygit',
        callback = function()
          if package.loaded['neo-tree.sources.git_status'] then
            require('neo-tree.sources.git_status').refresh()
          end
        end,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
