return { -- Autoformat
  'stevearc/conform.nvim',
  -- lazy = true,
  event = { 'BufReadPre', 'BufNewFile', 'BufReadPost' },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      -- Disable autoformat on certain filetypes
      local ignore_filetypes = { 'sql' }
      if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
        return
      end

      -- Disable autoformat for files in a certain path
      -- local bufname = vim.api.nvim_buf_get_name(bufnr)
      -- if bufname:match '/node_modules/' then
      --   return
      -- end

      return { timeout_ms = 500, lsp_fallback = true }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { { 'prettierd', 'prettier' } },
      html = { 'htmlbeautifier', 'prettierd', 'prettier' },
      php = { 'php' },
      markdown = { 'prettier', 'prettierd' },
      -- twig = { 'twig-cs-fixer' },
      twig = { 'twig' },
    },
    formatters = {
      php = {
        command = 'php-cs-fixer',
        args = {
          'fix',
          '$FILENAME',
          '--config=' .. vim.fn.stdpath 'config' .. '/lua/custom/tools/php-cs-fixer/.php-cs.php',
          '--allow-risky=yes', -- if you have risky stuff in config, if not you dont need it.
        },
        stdin = false,
      },
      twig = {
        command = 'twig-cs-fixer',
        args = {
          'lint',
          '--config=' .. vim.fn.stdpath 'config' .. '/lua/custom/tools/twig-cs-fixer/.twig-cs-fixer.php',
          '--fix',
          '$FILENAME',
        },
        stdin = false,
      },
    },
  },
  init = function()
    -- for reference look here https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
    -- https://github.com/stevearc/conform.nvim/issues/39

    local conform = require 'conform'
    local notify = require 'notify'

    local function show_notification(message, level)
      notify(message, level, { title = 'conform.nvim' })
    end

    -- Disable autoformat-on-save with a command
    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
        show_notification('Autoformat-on-save disabled for this buffer', 'info')
      else
        vim.g.disable_autoformat = true
        show_notification('Autoformat-on-save disabled globally', 'info')
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true,
    })

    -- Re-enable autoformat-on-save with a command
    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
      show_notification('Autoformat-on-save enabled', 'info')
    end, {
      desc = 'Re-enable autoformat-on-save',
    })

    -- Save without formatting
    vim.api.nvim_create_user_command('FormatSave', function()
      vim.b.disable_autoformat = true
      vim.cmd 'w'
      vim.b.disable_autoformat = false
      show_notification('Saved without formatting', 'info')
    end, {
      desc = 'Save without formatting',
    })

    -- Format the current buffer asynchronously
    vim.api.nvim_create_user_command('FormatAsync', function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ['end'] = { args.line2, end_line:len() },
        }
      end
      conform.format { async = true, lsp_fallback = true, range = range }
      show_notification('Asyncronous format started', 'info')
    end, { range = true })
  end,
  keys = {
    {
      '<leader>df',
      function()
        require('conform').format { async = true, lsp_fallback = true }
        require 'notify'('Formatting...', 'info', { title = 'conform.nvim' })
      end,
      mode = '',
      desc = '[D]ocument [F]ormat',
    },
    { '<leader>dFe', ':FormatEnable<CR>', mode = '', desc = '[D]ocument [F]ormat [E]nable' },
    { '<leader>dFd', ':FormatDisable<CR>', mode = '', desc = '[D]ocument [F]ormat [D]isable' },
    { '<leader>dFa', ':FormatAsync<CR>', mode = '', desc = '[D]ocument [F]ormat [A]sync' },
    { '<leader>f', ':FormatSave<CR>', mode = '', desc = 'Save without [F]ormatting' },
  },
}

-- vim: ts=2 sts=2 sw=2 et
