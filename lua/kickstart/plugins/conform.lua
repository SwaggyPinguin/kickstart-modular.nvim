return {
  { -- Autoformat
    'stevearc/conform.nvim',
    -- lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      notify_on_error = true,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
        async = false,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        javascript = { { 'prettierd', 'prettier' } },
        php = { 'php' },
        markdown = { 'prettier', 'prettierd' },
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
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
